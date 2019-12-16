class User < ActiveRecord::Base
  
  has_secure_password

  validates :name, presence: true
  validates :email, presence: true
  validates :password, length: { minimum: 8 }
  validates :password_confirmation, presence: true

  validates :email.downcase, uniqueness: true

end
