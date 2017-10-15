class User < ActiveRecord::Base

    has_many :reviews

    validates :name, presence: true
    validates :email, uniqueness: true
    has_secure_password
    
end
