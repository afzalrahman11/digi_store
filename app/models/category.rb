class Category < ApplicationRecord
    has_many :items, dependent: :destroy

    validates :name, :unit, presence: true
    validates :name, uniqueness: true
end
