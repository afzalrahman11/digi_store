FactoryBot.define do
  factory :category do
    name { Faker::Commerce.department }
    unit { %w[ kg litres pieces ].sample }
  end
end
