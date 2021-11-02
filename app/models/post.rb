class Post < ApplicationRecord
  belongs_to :user
  has_many :post_genres, dependent: :destroy
  has_many :genres, through: :post_genres
  has_many :post_genre_details, dependent: :destroy
  has_many :genre_details, through: :post_genre_details
end
