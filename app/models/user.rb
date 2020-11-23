class User < ActiveRecord::Base
  has_many :tweets

  has_secure_password
  validates :username, presence: true
  validates :email , presence: true
  validates :password , presence: true
  validates :username, uniqueness: true
 
 extend Slugable::ClassMethods
 include Slugable::InstanceMethods

  
end
