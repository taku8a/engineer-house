class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :project_members, dependent: :destroy
  has_many :project_chats, dependent: :destroy
  has_many :projects, through: :project_members
  has_many :posts, dependent: :destroy
  has_many :post_comments, dependent: :destroy

  attachment :profile_image, destroy: false

  validates :name, presence: true, uniqueness: true
  validates :introduction, presence: true
  validates :is_valid, inclusion: [true, false]
  validates :email, presence: true, uniqueness: true

  def short_name
    name.truncate(10)
  end

  def short_introduction
    introduction.truncate(10)
  end
end
