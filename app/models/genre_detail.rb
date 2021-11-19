class GenreDetail < ApplicationRecord
  belongs_to :genre
  has_many :post_genre_details, dependent: :destroy
  has_many :posts, through: :post_genre_details
  has_many :post_comment_genre_details, dependent: :destroy
  has_many :post_comments, through: :post_comment_genre_details

  validates :title, presence: true
  validates :body, presence: true

  def update_time
    updated_at.strftime("%Y/%m/%d %H:%M")
  end

  def short_title
    title.truncate(10)
  end

  def short_body
    body.truncate(10)
  end
end
