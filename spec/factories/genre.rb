FactoryBot.define do
  factory :genre do
    name { Faker::Lorem.characters(number: 10) }
    owner_id { Faker::Number.between(from: 1) }
  end
end