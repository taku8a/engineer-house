class CreateGenreDetails < ActiveRecord::Migration[5.2]
  def change
    create_table :genre_details do |t|
      t.string :title,      null: false, default: ""
      t.text :body,         null: false
      t.integer :post_id,   null: false
      t.integer :genre_id,  null: false

      t.timestamps
    end
  end
end
