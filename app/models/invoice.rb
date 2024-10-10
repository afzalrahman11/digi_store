class Invoice < ApplicationRecord
  belongs_to :user
  belongs_to :debtor

  enum payment_status: { paid: 0, debt: 1 }
  validates :payment_status, :total_amount, :date, presence: true
  validates :total_amount, numericality: { greater_than_or_equal_to: 0 }

  validate :date_not_in_future  # custom validation method

  private

  def date_not_in_future
    if date.present? && date > DateTime.now
      errors.add(:date, "can't be in future")
    end
  end
end
