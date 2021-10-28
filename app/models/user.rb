class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :project_members, dependent: :destroy
  has_many :project_chats, dependent: :destroy
  has_many :projects, through: :project_members

  attachment :profile_image
end
