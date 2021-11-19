class Genre < ApplicationRecord
  has_many :post_genres, dependent: :destroy
  has_many :posts, through: :post_genres
  has_many :genre_details, dependent: :destroy

  validates :name, presence: true, uniqueness: true

  def short_name
    name.truncate(10)
  end

  def has_owner(current_user)
    self.owner_id = current_user.id
  end
end
