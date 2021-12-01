FactoryBot.define do
  factory :post_genre_detail do
    association :post
    association :genre_detail
  end
end