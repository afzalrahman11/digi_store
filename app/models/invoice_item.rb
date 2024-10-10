class InvoiceItem < ApplicationRecord
  belongs_to :item
  belongs_to :invoice

  validates :quantity, :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
