class CreateVipLists < ActiveRecord::Migration[5.1]
  def change
    create_table :vip_lists do |t|
        t.integer :user_id, null: false
        t.foreign_key :users
        t.date :ending_date
      t.timestamps
    end
  end
end
