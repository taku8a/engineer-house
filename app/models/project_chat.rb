class ProjectChat < ApplicationRecord
  belongs_to :user
  belongs_to :project
  
  validates :chat, presence: true
  
  def make_time
    created_at.strftime("%Y/%m/%d %H:%M")
  end
end
