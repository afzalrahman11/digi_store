class Debtor < ApplicationRecord
  validates :name, :phone, :total_debt, presence: true
  validates :phone, uniqueness: true, format: { with: /\A[1-9]\d{9}\z/, message: "must be exactly 10 digits and cannot start with 0" }
end
