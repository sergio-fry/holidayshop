class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :product_id
      t.string :name
      t.string :phone
      t.string :email
      t.text :address

      t.string :uuid
      t.timestamps
    end

    add_index :orders, :uuid, :unique => true
  end
end
