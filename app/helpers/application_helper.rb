module ApplicationHelper
  def is_admin? user_id, event_id
    EventUser.is_admin?(user_id, event_id)
  end
  def custom_format value, format
    if value.present? && format.present?
      value.to_s + format
    end
  end
  def current_env
    raw ENV["RAILS_ENV"].to_json;
  end
end
