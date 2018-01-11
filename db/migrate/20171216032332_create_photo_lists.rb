class CreatePhotoLists < ActiveRecord::Migration[5.1]
  def up
    create_table :photo_lists do |t|
      t.integer :type, null: false #1 (san pham) or 2 (user)
      t.text :url
      t.timestamps
    end
  end
  def dowwn
      drop_table :photo_lists
  end
end
