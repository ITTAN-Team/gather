class Event < ApplicationRecord
  has_many :event_images
  has_many :event_users, dependent: :destroy
  has_many :users, through: :event_users
  accepts_nested_attributes_for :event_users
  geocoded_by :address
  after_validation :geocode

  mount_uploader :image, ImageUploader

  def self.get_sponsorship_events user_id
    EventUser.where('user_id = ? AND admin = ?', user_id, true)
  end

  def self.search_sponsorship_events user_id, event_id
    EventUser.where('user_id = ? AND event_id = ? AND admin = ?', user_id, event_id, true)
  end

  def self.get_invited_events user_id
    EventUser.where('user_id = ? AND admin = ?', user_id, false)
  end

  def self.search_participateds_events user_id, event_id
    EventUser.where('user_id = ? AND event_id = ? AND admin = ?', user_id, event_id, false)
  end

  validates :name, {presence: true, length: {maximum: 255}}
  validates :description, length: {maximum: 65535}
  validates :location_name, length: {maximum: 255}
  validates :location_url, length: {maximum: 65535}
  validates :address, length: {maximum: 65535}
  validates :link, length: {maximum: 65535}
  validates :image, length: {maximum: 65535}

  validate :date_cannot_be_in_the_past

  def date_cannot_be_in_the_past
    if event_date.present? && event_date < Date.today
      errors.add('開催日', ': 過去の日付は使用できません')
    end
  end
end