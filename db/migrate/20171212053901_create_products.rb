class CreateProducts < ActiveRecord::Migration[5.1]
  def up
    create_table :products do |t|
      t.string :name
      t.text :description
      t.string :image
      t.boolean :is_multi_language
      t.integer :buy_now_price
      t.integer :starting_price
      t.integer :current_price
      t.integer :rising_price
      t.integer :hours_to_bid
      t.integer :current_price
      t.integer :max_price
      t.integer :winner
      t.string :status
      t.string :reason
      t.string :category
      t.integer :seller_id
      t.integer :accepter_id
      t.datetime :accepted_time
      t.datetime :end_time
      t.boolean :can_edit
      t.timestamps
    end
    add_foreign_key :products, :users, column: :seller_id,  primary_key: :id, name: :fk_users_products
  end
  def down
    remove_foreign_key :products, name: :fk_users_products
    drop_table :products, force: :cascade
  end
end
