module EventsHelper
  def is_join? status
    return status == 1
  end

  def is_leave? status
    return status == 0
  end
end
