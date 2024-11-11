class Debtor < ApplicationRecord
  include ValidationPatterns

  # Validates presence of name, phone, email, and total_debt columns
  validates :name, :phone, :email, :total_debt, presence: true

  # Ensures total_debt is non-negative
  validates :total_debt, numericality: { greater_than_or_equal_to: 0 }

  # Validates uniqueness and format for phone and email
  validates :phone, uniqueness: true, format: { with: PHONE_REGEX, message: PHONE_REGEX_MESSAGE }
  validates :email, uniqueness: true, format: { with: EMAIL_REGEX, message: EMAIL_REGEX_MESSAGE }
end
