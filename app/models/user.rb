class User < ActiveRecord::Base
  has_many :tweets

  has_secure_password
  validates :username, presence: true
  validates :password_digest, :email, presence: true
  validates :email, uniqueness: true


  def slug
    username.parameterize
  end

  def self.find_by_slug(slug)
    self.all.find{|user| user.slug == slug}
  end
end
