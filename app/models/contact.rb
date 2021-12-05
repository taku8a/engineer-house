class Contact < ApplicationRecord

  validates :name, presence: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, {presence: true, format: { with: VALID_EMAIL_REGEX }}
  validates :content, presence: true
  
  def highly
    self.score >= 0.8
  end
  
  def little_good
    self.score < 0.8 && self.score >= 0.2
  end
  
  def moderately
    self.score < 0.2 && self.score > -0.2
  end
  
  def little_bad
    self.score <= -0.2 && self.score > -0.8
  end
end
