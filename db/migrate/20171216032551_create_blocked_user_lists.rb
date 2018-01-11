class CreateBlockedUserLists < ActiveRecord::Migration[5.1]
  def change
    create_table :blocked_user_lists do |t|
      t.integer :blocked_user_id
      t.integer :accepter_blocked_user_id
      t.datetime :ending_date
      t.integer :block_level
      t.timestamps
    end
    add_foreign_key :blocked_user_lists, :users, column: :blocked_user_id,  primary_key: :id, name: :fk_blocked_user
  end
  def down
    remove_foreign_key :blocked_user_lists, name: :fk_blocked_user
    drop_table :blocked_user_lists
  end
end
