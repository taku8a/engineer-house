FactoryBot.define do
  factory :post_comment_genre_detail do
    association :post_comment
    association :genre_detail
  end
end