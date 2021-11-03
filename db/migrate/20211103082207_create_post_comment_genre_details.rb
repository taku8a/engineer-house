class CreatePostCommentGenreDetails < ActiveRecord::Migration[5.2]
  def change
    create_table :post_comment_genre_details do |t|
      t.integer :post_comment_id,  null: false, default: ""
      t.integer :genre_detail_id,  null: false, default: ""

      t.timestamps
    end
  end
end
