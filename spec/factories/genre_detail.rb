FactoryBot.define do
  factory :genre_detail do
    association :genre
    body { Faker::Lorem.characters(number: 20) }
    title { Faker::Lorem.characters(number: 10) }
  end
end