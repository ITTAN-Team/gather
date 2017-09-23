class EventUser < ApplicationRecord
  belongs_to :event, foreign_key: :event_id
  belongs_to :user, foreign_key: :user_id

  def self.is_admin? user_id, event_id
    event_user = EventUser.where('user_id = ? AND event_id = ?', user_id, event_id)
    if event_user.present? && event_user.size == 1
      event_user.first.admin
    else
      return false
    end
  end

end
