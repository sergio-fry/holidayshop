class Product < ActiveRecord::Base
  attr_accessible *[
    :category_id,
    :description,
    :origin_id,
    :pictures_attributes,
    :price,
    :price2,
    :title,
  ]

  acts_as_gallery
  belongs_to :category
  validates :origin_id, :uniqueness => true
end
