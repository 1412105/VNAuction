class ChangeObject < ActiveRecord::Migration[5.1]
  def self.up
    add_column :users, :is_vip, :boolean
  end
  def self.down
    remove_column :users, :is_vip
  end
end
