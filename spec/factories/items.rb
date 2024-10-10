FactoryBot.define do
  factory :item do
    name { "MyString" }
    quantity { "9.99" }
    unit { "MyString" }
    price { "9.99" }
    category { nil }
  end
end
