FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    role { User.roles.keys.sample }
    password { "passme123" }
    password_confirmation { "passme123" }
  end
end
