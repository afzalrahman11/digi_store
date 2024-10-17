FactoryBot.define do
  factory :invoice_item do
    quantity { rand(1.00..500.00).round(2) }
    price { rand(100.00..1000.00).round(2) }
    association :item
    association :invoice
  end
end
