class AddPostCommentIdToPostGenreDetails < ActiveRecord::Migration[5.2]
  def change
    add_column :post_genre_details, :post_comment_id, :integer
  end
end
