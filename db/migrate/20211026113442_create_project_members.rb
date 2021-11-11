class CreateProjectMembers < ActiveRecord::Migration[5.2]
  def change
    create_table :project_members do |t|
      t.integer :user_id,    null: false
      t.integer :project_id, null: false

      t.timestamps
    end
  end
end
