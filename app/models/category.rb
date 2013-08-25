class Category < ActiveRecord::Base
  has_many :products
  default_scope :order => "order_index IS NULL, order_index"
end
