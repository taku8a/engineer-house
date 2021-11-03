class PostComment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  has_many :post_comment_genre_details, dependent: :destroy
  has_many :genre_detail, through: :post_comment_genre_details
end
