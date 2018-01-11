class CreateReportedUserLists < ActiveRecord::Migration[5.1]
  def up
    create_table :reported_user_lists do |t|
      t.integer :reported_user_id
      t.integer :reporter_id
      t.text :reason
      t.timestamps
    end
    add_foreign_key :reported_user_lists, :users, column: :reported_user_id,  primary_key: :id, name: :fk_reported_user1
    add_foreign_key :reported_user_lists, :users, column: :reporter_id,  primary_key: :id, name: :fk_reported_user2
  end
  def down
    remove_foreign_key :reported_user_lists, name: :fk_reported_user1
    remove_foreign_key :reported_user_lists, name: :fk_reported_user2
    drop_table :reported_user_lists
  end
end
