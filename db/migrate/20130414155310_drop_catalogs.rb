class DropCatalogs < ActiveRecord::Migration
  def up
    drop_table :catalogs
  end

  def down
    create_table "catalogs" do |t|
      t.datetime "created_at",        :null => false
      t.datetime "updated_at",        :null => false
      t.string   "file_file_name"
      t.string   "file_content_type"
      t.integer  "file_file_size"
      t.datetime "file_updated_at"
    end
  end
end
