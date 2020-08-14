class User < ActiveRecord::Base
    has_secure_password

    has_many :jobs

    validates :username, presence: true
    validates :email, presence: true
end