class AddDebtorColumnsToInvoices < ActiveRecord::Migration[7.2]
  def change
    add_column :invoices, :debtor_name, :string
    add_column :invoices, :debtor_phone, :string
  end
end
