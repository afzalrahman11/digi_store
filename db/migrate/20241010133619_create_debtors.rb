class CreateDebtors < ActiveRecord::Migration[7.2]
  def change
    create_table :debtors do |t|
      t.string :name
      t.string :phone
      t.decimal :total_debt, precision: 10, scale: 2

      t.timestamps
    end
  end
end
