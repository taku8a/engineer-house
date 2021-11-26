FactoryBot.define do
  factory :post do
    association :user
    body { Faker::Lorem.characters(number: 20) }
    title { Faker::Lorem.characters(number: 10) }
  end
end