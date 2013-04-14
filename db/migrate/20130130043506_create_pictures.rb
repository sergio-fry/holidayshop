class CreatePictures < ActiveRecord::Migration
  def self.up
    create_table :pictures do |t|
      t.string :gallery_type
      t.integer :gallery_id
      t.attachment :file
      t.timestamps
    end

    add_index :pictures, [:gallery_id, :gallery_type]
  end

  def self.down
    drop_table :pictures
  end
end
