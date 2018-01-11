class CreateBlockedProductLists < ActiveRecord::Migration[5.1]
  def up
    create_table :blocked_product_lists do |t|
      t.integer :blocked_product_id
      t.integer :accepter_blocked_product_id
      t.timestamps
    end
    add_foreign_key :blocked_product_lists, :products, column: :blocked_product_id,  primary_key: :id, name: :fk_blocked_product
  end
  def down
    remove_foreign_key :blocked_product_lists, name: :fk_blocked_product
    drop_table :blocked_product_lists
  end
end
