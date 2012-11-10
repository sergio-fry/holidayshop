class Product < ActiveRecord::Base
  attr_accessible :description, :origin_id, :price, :title
  validates :origin_id, :uniqueness => true
end
