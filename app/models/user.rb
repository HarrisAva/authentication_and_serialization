class User < ApplicationRecord
    # has_secure_password -> Rails checks to see if the password and password_confirmation fields match when creating a new user
    has_secure_password
    validates :username, presence: true
    has_many :posts
end
