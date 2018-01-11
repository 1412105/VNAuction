class UpdateProduct < ActiveRecord::Migration[5.1]
  def up
      execute <<-SQL
           SAVEPOINT update_product_id_1;
           UPDATE products
           SET status = 'Bidding', end_time = '2018-10-1'::timestamp
           WHERE id = 1;
       SQL
  end
  def down
      execute <<-SQL
      ROLLBACK TO my_savepoint;
      SQL
  end
end
