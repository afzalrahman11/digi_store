class AddEmailToDebtors < ActiveRecord::Migration[7.2]
  def change
    add_column :debtors, :email, :string
  end
end
