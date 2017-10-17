class User < ActiveRecord::Base

    has_many :reviews

    validates :name, presence: true
    validates :email, uniqueness: true, presence: true
    validates :password, presence: true, length: { minimum: 3 }
    validates :password_confirmation, presence: true, length: { minimum: 3 }
    has_secure_password

    def self.authenticate_with_credentials(email, password)
        @user = User.find_by_email(email.to_s.downcase.strip)
        if @user && @user.authenticate(password)
          @user
        else
          nil
        end
    end
    
end
