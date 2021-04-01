class User < ApplicationRecord
    has_many :tasks
    has_many :projects, through: :tasks

    has_secure_password
    validates_uniqueness_of :username
    validates_presence_of :username
end
