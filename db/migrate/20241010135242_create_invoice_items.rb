class CreateInvoiceItems < ActiveRecord::Migration[7.2]
  def change
    create_table :invoice_items do |t|
      t.references :item, null: false, foreign_key: true
      t.references :invoice, null: false, foreign_key: true
      t.decimal :quantity
      t.decimal :price, precision: 10, scale: 2

      t.timestamps
    end
  end
end
