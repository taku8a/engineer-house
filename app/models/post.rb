class Post < ApplicationRecord
  belongs_to :user
  has_many :post_genres, dependent: :destroy
  has_many :genres, through: :post_genres
  has_many :post_genre_details, dependent: :destroy
  has_many :genre_details, through: :post_genre_details
  has_many :post_comments, dependent: :destroy

  validates :title, presence: true
  validates :body, presence: true

  def short_title
    title.truncate(10)
  end

  def make_time
    created_at.strftime("%Y/%m/%d %H:%M")
  end

  def short_body
    body.truncate(10)
  end

  def self.newly
    limit(5).order('id DESC')
  end
end
