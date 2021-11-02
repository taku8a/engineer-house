class RemovePostIdFromGenreDetails < ActiveRecord::Migration[5.2]
  def change
    remove_column :genre_details, :post_id, :integer
  end
end
