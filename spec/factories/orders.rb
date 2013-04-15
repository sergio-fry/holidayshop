# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :order do
    product_id 1
    name "MyString"
    phone "MyString"
    email "MyString"
    address "MyString"
  end
end
