class Genre < ApplicationRecord
  has_many :post_genres, dependent: :destroy
  has_many :posts, through: :post_genres
  has_many :genre_details, dependent: :destroy
end
