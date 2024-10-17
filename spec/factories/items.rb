FactoryBot.define do
  factory :item do
    name { Faker::Commerce.product_name }
    quantity { rand(1..100) }
    unit { %w[ kg litres pieces ].sample }
    price { rand(5.00..500.00).round(2) }
    association :category
  end
end
