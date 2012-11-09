# encoding: utf-8
class Catalog < ActiveRecord::Base
  attr_accessible :file
  has_attached_file :file

  class ProductsEnumerable
    include Enumerable

    def initialize(xls_path)
      @xls_path = xls_path
    end

    def each
      sheet = Excel.new(@xls_path)

      current_row_index = 0

      while(current_row_index < 20)
        row = sheet.row(current_row_index)

        item = {
          :title => row[0],
          :origin_id => row[5].to_s,
          :price => row[6].to_s.gsub(",", ".").gsub(/[^[:digit:]\.]+/, ""),
        }
        p item if self.class.valid_item?(item)

        yield(item) if self.class.valid_item?(item)

        current_row_index += 1
      end
    end

    private

    def self.valid_item?(item)
      item[:title].present? &&
        item[:origin_id].present? && item[:origin_id] != "Номенклатура.Код" &&
        item[:price].present? && (Float(item[:price]) rescue false)
    end
  end

  def products_attrs
    ProductsEnumerable.new(self.file.path).to_a
  end

  def process!
    products_attrs.each do |attrs|
      Product.create attrs
    end
  end
end
