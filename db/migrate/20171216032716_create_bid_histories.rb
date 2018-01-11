class CreateBidHistories < ActiveRecord::Migration[5.1]
  def change
    create_table :bid_histories do |t|
      t.integer :user_id
      t.integer :product_id
      t.integer :price
      t.timestamps
    end
  end
end
