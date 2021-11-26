FactoryBot.define do
  factory :post_comment do
    association :post
    association :user
    comment { Faker::Lorem.characters(number: 20) }
  end
end