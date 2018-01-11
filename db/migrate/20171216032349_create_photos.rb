class CreatePhotos < ActiveRecord::Migration[5.1]
  def change
    create_table :photos do |t|
      t.integer :photo_list_id
      t.timestamps
    end
    add_foreign_key :photos, :photo_lists, column: :photo_list_id,  primary_key: :id, name: :fk_photo_photo_list
  end
  def down
    drop_table :photo
  end
end
