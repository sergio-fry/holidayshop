# encoding: utf-8
class Product < ActiveRecord::Base
  attr_accessible *[
    :age,
    :category_id,
    :country,
    :description,
    :height,
    :length,
    :model,
    :origin_id,
    :pictures_attributes,
    :price,
    :price2,
    :size,
    :title,
    :type_prefix,
    :vendor,
    :vendor_code,
    :weight,
    :width,
  ]

  OPTIONS = {
    :description => "Описание",
    :type_prefix => "Тип", 
    :vendor => "Производитель", 
    :model => "Модель", 
    :vendor_code => "Код производителя", 
    :country => "Страна", 
    :width => "Ширина, см", 
    :length => "Длина, см", 
    :height => "Высота, см", 
    :weight => "Вес, кг", 
    :size => "Размер", 
    :age => "Возраст", 
  }

  acts_as_gallery
  belongs_to :category
  validates :origin_id, :uniqueness => true
end
