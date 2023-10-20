class User < ApplicationRecord
  has_many :posts
  has_many :favorites, dependent: :destroy
  has_many :postconfirms

  mount_uploader :icon, IconUploader

  validates :name, presence: true, length: { maximum: 30 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  validates :email, uniqueness: true
  validates :password, length: { minimum: 6 }, on: :create
  has_secure_password
  validates :icon, presence: true
  before_validation { email.downcase! }
end
