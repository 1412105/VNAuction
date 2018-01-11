class CreateCategoryProductLists < ActiveRecord::Migration[5.1]
  def change
    create_table :category_product_lists do |t|

      t.timestamps
    end
  end
end
