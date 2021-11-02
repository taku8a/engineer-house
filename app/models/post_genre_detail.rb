class PostGenreDetail < ApplicationRecord
  belongs_to :post
  belongs_to :genre_detail
end
