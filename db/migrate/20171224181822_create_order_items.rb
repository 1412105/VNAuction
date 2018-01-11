class CreateOrderItems < ActiveRecord::Migration[5.1]
  def change
    create_table :order_items do |t|
      t.integer :product_id
      t.integer :order_id
      t.integer :unit_price
      t.integer :quantity
      t.integer :total_price

      t.timestamps
    end
  end
end
