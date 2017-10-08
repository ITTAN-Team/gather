class Event < ApplicationRecord
  has_many :event_images
  has_many :event_users
  has_many :users, through: :event_users
  accepts_nested_attributes_for :event_users

  mount_uploader :image, ImageUploader

  def self.get_sponsorship_events user_id
    EventUser.where('user_id = ? AND admin = ?', user_id, true)
  end

  def self.search_sponsorship_events user_id, event_id
    EventUser.where('user_id = ? AND event_id = ? AND admin = ?', user_id, event_id, true)
  end

  def self.get_participateds_events user_id
    EventUser.where('user_id = ? AND admin = ?', user_id, false)
  end

  def self.search_participateds_events user_id, event_id
    EventUser.where('user_id = ? AND event_id = ? AND admin = ?', user_id, event_id, false)
  end

  validates :name, {presence: true, length: {maximum: 255}}
  validates :description, length: {maximum: 65535}
  validates :location_url, length: {maximum: 65535}
  validates :address, length: {maximum: 65535}
  validates :link, length: {maximum: 65535}
  validates :image, length: {maximum: 65535}
end