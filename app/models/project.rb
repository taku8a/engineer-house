class Project < ApplicationRecord
  has_many :project_members, dependent: :destroy
  has_many :project_chats, dependent: :destroy

  attachment :project_image
end
