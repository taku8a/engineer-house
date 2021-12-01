FactoryBot.define do
  factory :project_chat do
    chat { Faker::Lorem.characters(number: 20) }
    association :user
    association :project
  end
end