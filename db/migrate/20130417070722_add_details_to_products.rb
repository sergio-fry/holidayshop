class AddDetailsToProducts < ActiveRecord::Migration
  def change
    add_column :products, :type_prefix, :string
    add_column :products, :vendor, :string
    add_column :products, :vendor_code, :string
    add_column :products, :model, :string
    add_column :products, :country, :string

    add_column :products, :width, :integer
    add_column :products, :height, :integer
    add_column :products, :length, :integer

    add_column :products, :size, :string
    add_column :products, :age, :string

    add_column :products, :weight, :float
  end
end
