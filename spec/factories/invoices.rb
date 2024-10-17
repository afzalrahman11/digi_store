FactoryBot.define do
  factory :invoice do
    payment_status { Invoice.payment_statuses.keys.sample }
    date { Faker::Date.backward(days: 14) }
    total_amount { rand(1.00..1000.00).round(2) }
    association :user
    association :debtor
  end
end
