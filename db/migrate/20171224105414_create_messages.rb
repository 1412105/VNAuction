class CreateMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :messages do |t|
      t.integer :user_id
      t.integer :product_id
      t.text :content
      t.string :typee
      
      t.timestamps
    end
  end
end
