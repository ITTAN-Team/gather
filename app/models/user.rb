class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :event_users
  has_many :events, through: :event_users

  validates :email, {presence: true, uniqueness: true, length: {maximum: 255}}
  validates :encrypted_password, {presence: true, length: {maximum: 255}}
  validates :sei, length: {maximum: 255}
  validates :mei, length: {maximum: 255}
  validates :image, length: {maximum: 65535}
end
