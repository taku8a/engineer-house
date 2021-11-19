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

  def short_introduction
    introduction.truncate(10)
  end

  def make_time
    created_at.strftime("%Y/%m/%d %H:%M")
  end

  def full
    self.users.count >= 4
  end

  def assigned(current_user)
    users.include?(current_user)
  end
end
