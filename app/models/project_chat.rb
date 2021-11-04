class ProjectChat < ApplicationRecord
  belongs_to :user
  belongs_to :project
  
  validates :chat, presence: true
end
