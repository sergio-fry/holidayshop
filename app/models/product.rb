class Product < ActiveRecord::Base
  attr_accessible *[
    :description,
    :origin_id,
    :price,
    :price2,
    :title,
    :pictures_attributes,
  ]

  acts_as_gallery
  validates :origin_id, :uniqueness => true
end
