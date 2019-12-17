class User < ActiveRecord::Base
  
  has_secure_password

  validates :name, presence: true
  validates :email, presence: true
  validates :password, length: { minimum: 8 }
  validates :password_confirmation, presence: true

  validates :email, uniqueness: { case_sensitive: false }

  def authenticate_with_credentials(param_email, param_password) 
    user = User.find_by_email(param_email)
  
    if user && user.authenticate(param_password)
      return user
    else
      return nil
    end

  end

end


