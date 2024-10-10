class CreateInventories < ActiveRecord::Migration[7.2]
  def change
    create_table :inventories do |t|
      t.references :item, null: false, foreign_key: true
      t.decimal :stock_quantity

      t.timestamps
    end
  end
end
