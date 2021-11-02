class GenreDetail < ApplicationRecord
  belongs_to :genre
  has_many :post_genre_details, dependent: :destroy
  has_many :posts, through: :pos
end
