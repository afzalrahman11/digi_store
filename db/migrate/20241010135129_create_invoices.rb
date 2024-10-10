class CreateInvoices < ActiveRecord::Migration[7.2]
  def change
    create_table :invoices do |t|
      t.references :user, null: false, foreign_key: true
      t.references :debtor, null: false, foreign_key: true
      t.integer :payment_status
      t.datetime :date
      t.decimal :total_amount, precision: 10, scale: 2

      t.timestamps
    end
  end
end
