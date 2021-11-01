class CreateGenres < ActiveRecord::Migration[5.2]
  def change
    create_table :genres do |t|
      t.integer :owner_id,          null: false, default: ""
      t.string :name,               null: false, default: ""

      t.timestamps
    end
  end
end
