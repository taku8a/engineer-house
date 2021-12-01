FactoryBot.define do
  factory :contact do
    content { Faker::Lorem.characters(number: 20) }
    name { Faker::Name.name }
    email { Faker::Internet.email }
  end
end