class Item < ApplicationRecord
  belongs_to :category

  validates :name, :unit, :quantity, :price, presence: true
  validates :name, uniqueness: true
  validates :price, :quantity, numericality: { greater_than_or_equal_to: 0 }
end
