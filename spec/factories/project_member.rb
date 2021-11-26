FactoryBot.define do
  factory :project_member do
    association :user
    association :project
  end
end