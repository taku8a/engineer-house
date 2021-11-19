class Post < ApplicationRecord
  belongs_to :user
  has_many :post_genres, dependent: :destroy
  has_many :genres, through: :post_genres
  has_many :post_genre_details, dependent: :destroy
  has_many :genre_details, through: :post_genre_details
  has_many :post_comments, dependent: :destroy

  validates :title, presence: true
  validates :body, presence: true

  def short_title
    title.truncate(10)
  end
end
