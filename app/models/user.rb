class User < ApplicationRecord
    has_secure_password
    has_many :categories, dependent: :destroy
    
    validates :username, presence: true
    validates :email, presence: true
  end