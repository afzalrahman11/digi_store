class AddDebtorEmailToInvoices < ActiveRecord::Migration[7.2]
  def change
    add_column :invoices, :debtor_email, :string
  end
end
