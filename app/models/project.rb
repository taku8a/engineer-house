class Project < ApplicationRecord
  has_many :project_members, dependent: :destroy
  has_many :project_chats, dependent: :destroy
  has_many :users, through: :project_members

  attachment :project_image, destroy: false

  validates :name, presence: true
  validates :introduction, presence: true

  def short_name
    name.truncate(10)
  end
end
