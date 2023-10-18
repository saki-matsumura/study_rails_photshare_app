class Post < ApplicationRecord
  belongs_to :user

  mount_uploader :image, IconUploader

  validates :content, presence: true, length: { maximum: 140 }
end
