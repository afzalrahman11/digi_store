FactoryBot.define do
  factory :invoice do
    user { nil }
    debtor { nil }
    payment_status { 1 }
    date { "2024-10-10 19:21:29" }
    total_amount { "9.99" }
  end
end
