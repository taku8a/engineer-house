class PostComment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  has_many :post_comment_genre_details, dependent: :destroy
  has_many :genre_details, through: :post_comment_genre_details

  validates :comment, presence: true

  def short_comment
    comment.truncate(10)
  end
end
