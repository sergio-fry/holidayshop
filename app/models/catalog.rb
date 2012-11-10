# encoding: utf-8
class Catalog < ActiveRecord::Base
  attr_accessible :file
  has_attached_file :file

  BATCH_SIZE = 100
  after_commit lambda { delay.process!(0, BATCH_SIZE) }

  class ProductRow
    def initialize(attributes)
      @attributes = attributes
    end

    def attributes_for_product
      {
        :title => @attributes[0],
        :origin_id => @attributes[5].to_s,
        :price => @attributes[6].to_s.gsub(",", ".").gsub(/[^[:digit:]\.]+/, ""),
      }
    end

    def valid?()
      attributes_for_product[:title].present? &&
        attributes_for_product[:origin_id].present? && attributes_for_product[:origin_id] != "Номенклатура.Код" &&
        attributes_for_product[:price].present? && (Float(attributes_for_product[:price]) rescue false)
    end
  end

  def products_attrs
    Rails.cache.fetch "Catalog##{id}#products_attrs" do
      result = []

      sheet = Excel.new(self.file.path)
      failed_tries_left = 20
      current_row_index = 0
      current_product_row = nil


      while failed_tries_left > 0
        current_product_row = product_row = ProductRow.new(sheet.row(current_row_index))

        if product_row.valid?
          result << product_row.attributes_for_product if product_row.valid?
          failed_tries_left = 20
        else
          failed_tries_left -= 1
        end

        current_row_index += 1
      end

      result
    end
  end

  def process!(from = 0, num = nil)
    return if products_attrs.size == 0

    num = num.to_i > 0 ? num : products_attrs.size
    to = from + num - 1

    attributes_batch = products_attrs[from..to]

    attributes_batch.each do |attrs|
      product = Product.find_or_initialize_by_origin_id(attrs[:origin_id])
      product.attributes = attrs
      product.save
    end

    # если есть еще необработанные строки
    if products_attrs.size > (to + 1)
      delay.process!(to + 1, num)
    end

    attributes_batch.size
  end
end
