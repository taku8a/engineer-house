class CreateProjectChats < ActiveRecord::Migration[5.2]
  def change
    create_table :project_chats do |t|
      t.integer :user_id,    null: false, default: ""
      t.integer :project_id, null: false, default: ""
      t.text :chat,          null: false

      t.timestamps
    end
  end
end
