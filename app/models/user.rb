class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets

  validates :username, presence: true
  validates :email, presence: true
  validates :password, presence: true

  attr_reader :slug
  
  def slug
    self.username.split.join("-")
  end

  def self.find_by_slug(slug)
    name = slug.split("-").join(" ")
    User.find_by(username: name)
  end

end
