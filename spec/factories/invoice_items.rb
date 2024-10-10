FactoryBot.define do
  factory :invoice_item do
    item { nil }
    invoice { nil }
    quantity { "9.99" }
    price { "9.99" }
  end
end
