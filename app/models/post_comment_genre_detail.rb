class PostCommentGenreDetail < ApplicationRecord
  belongs_to :genre_detail
  belongs_to :post_comment
end
