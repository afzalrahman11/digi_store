class Category < ApplicationRecord
    has_many :items, dependent: :destroy

    validates :name, :unit, presence: true, uniqueness: true
end
