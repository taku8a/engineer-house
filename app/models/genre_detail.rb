class GenreDetail < ApplicationRecord
  belongs_to :genre
  has_many :post_genre_details, dependent: :destroy
  has_many :posts, through: :post_genre_details
  has_many :post_comment_genre_details, dependent: :destroy
  has_many :post_comments, through: :post_comment_genre_details
  
  validates :title, presence: true
  validates :body, presence: true
end
