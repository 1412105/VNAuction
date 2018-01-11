class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
        t.string :password_hash
        t.string :name
        t.string :typee
        t.string :status
        t.string :email, unique: true
        t.string :phone_number, unique: true
        t.string :address
        t.integer :posted_this_month
        t.timestamps
    end
  end
end
