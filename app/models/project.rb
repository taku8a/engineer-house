class Project < ApplicationRecord
  has_many :project_members, dependent: :destroy
  has_many :project_chats, dependent: :destroy
  has_many :users, through: :project_members
  has_many :users, through: :project_chats

  attachment :project_image
end
