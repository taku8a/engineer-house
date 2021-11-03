class CreatePostComments < ActiveRecord::Migration[5.2]
  def change
    create_table :post_comments do |t|
      t.text :comment,          null: false, default: ""
      t.integer :user_id,       null: false, default: ""
      t.integer :post_id,       null: false, default: ""

      t.timestamps
    end
  end
end
