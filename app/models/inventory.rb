class Inventory < ApplicationRecord
  belongs_to :item

  validates :stock_quantity, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
