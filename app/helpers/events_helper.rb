module EventsHelper
  def self.is_join? status
    return status == 1
  end

  def self.is_leave? status
    return status == 0
  end
end
