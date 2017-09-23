class Event < ApplicationRecord
  has_many :event_images
  has_many :event_users
  has_many :users, through: :event_users

  mount_uploader :image, ImageUploader
end