FactoryBot.define do
  factory :debtor do
    name { Faker::Name.name }
    phone { Faker::PhoneNumber.cell_phone_in_e164[1..10] }
    total_debt { rand(100..2500).round(2) }
  end
end
