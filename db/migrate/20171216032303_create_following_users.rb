class CreateFollowingUsers < ActiveRecord::Migration[5.1]
  def up
    create_table :following_users do |t|
      t.integer :user_id, null: false
      t.integer :followed_id, null: false
      t.timestamps
    end
    add_foreign_key :following_users, :users, column: :user_id,  primary_key: :id, name: :fk_users_following_1
    add_foreign_key :following_users, :users, column: :followed_id,  primary_key: :id, name: :fk_users_following_2
  end
  def down
    remove_foreign_key :following_users, name: :fk_users_following_1
    remove_foreign_key :following_users, name: :fk_users_following_2
    drop_table :following_users
  end
end
