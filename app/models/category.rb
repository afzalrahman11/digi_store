class Category < ApplicationRecord
    has_many :items, dependent: :destroy

    validates :name, :unit, presence: true
    validates_uniqueness_of :name
end
