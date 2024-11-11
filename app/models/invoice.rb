class Invoice < ApplicationRecord
  belongs_to :user
  belongs_to :debtor
  include ValidationPatterns

  enum payment_status: { paid: 0, debt: 1 }
  validates :payment_status, :total_amount, :date, presence: true
  validates :total_amount, numericality: { greater_than_or_equal_to: 0 }

  with_options if: :debt? do
    validates :debtor_name, presence: true
    validates :debtor_phone, presence: true, uniqueness: true, format: { with: PHONE_REGEX, message: PHONE_REGEX_MESSAGE }
    validates :debtor_email, presence: true, uniqueness: true, format: { with: EMAIL_REGEX, message: EMAIL_REGEX_MESSAGE }
  end

  validate :date_not_in_future  # custom validation method

  private

  def date_not_in_future
    if date.present? && date > DateTime.now
      errors.add(:date, "can't be in the future")
    end
  end
end
