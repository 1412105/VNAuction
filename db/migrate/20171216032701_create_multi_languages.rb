class CreateMultiLanguages < ActiveRecord::Migration[5.1]
  def change
    create_table :multi_languages do |t|

      t.timestamps
    end
  end
end
