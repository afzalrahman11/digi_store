FactoryBot.define do
  factory :inventory do
    stock_quantity { rand(1.00..500.00).round(2) }
    association :item
  end
end
