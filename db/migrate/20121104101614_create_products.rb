class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :title
      t.string :origin_id
      t.text :description
      t.float :price

      t.timestamps
    end

    add_index :products, :origin_id, :unique => true
  end
end
