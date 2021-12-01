FactoryBot.define do
  factory :post_genre do
    association :post
    association :genre
  end
end