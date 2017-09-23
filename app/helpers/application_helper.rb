module ApplicationHelper
  def is_admin? user_id, event_id
    EventUser.is_admin?(user_id, event_id)
  end
end
