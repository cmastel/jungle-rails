class User < ActiveRecord::Base
  
  has_secure_password

  validates :name, presence: true
  validates :email, presence: true
  validates :password, length: { minimum: 8 }
  validates :password_confirmation, presence: true

  validates :email, uniqueness: { case_sensitive: false }

  def authenticate_with_credentials(param_email, param_password) 
    email = param_email.strip
    user = User.where("lower(email) = ?", email.downcase).first
  
    if user && user.authenticate(param_password)
      return user
    else
      return nil
    end

  end

end

