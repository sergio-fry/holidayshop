class AddOrderIndexToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :order_index, :integer
  end
end
