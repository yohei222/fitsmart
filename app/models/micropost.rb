class Micropost < ApplicationRecord
  belongs_to :user
  mount_uploader :picture, PictureUploader
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 100 }
end
