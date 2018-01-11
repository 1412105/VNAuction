class CreateReportedProductLists < ActiveRecord::Migration[5.1]
  def up
    create_table :reported_product_lists do |t|
      t.integer :reported_product_id
      t.integer :reporter_id
      t.text :reason
      t.timestamps
    end
    add_foreign_key :reported_product_lists, :products, column: :reported_product_id,  primary_key: :id, name: :fk_reported_product
    add_foreign_key :reported_product_lists, :users, column: :reporter_id,  primary_key: :id, name: :fk_reported_user
  end
  def down
    remove_foreign_key :reported_product_lists, name: :fk_reported_product
    remove_foreign_key :reported_product_lists, name: :fk_reported_user
    drop_table :reported_product_lists
  end
end
