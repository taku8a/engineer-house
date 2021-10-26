class CreateProjects < ActiveRecord::Migration[5.2]
  def change
    create_table :projects do |t|
      t.string  :name,              null:false, default: ""
      t.text    :introduction,      null:false, default: ""
      t.integer :owner_id,          null:false, default: ""
      t.string  :project_image_id,  null:false, default: ""

      t.timestamps
    end
  end
end
