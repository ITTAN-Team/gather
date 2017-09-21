class EventImage < ApplicationRecord
  belongs_to :event, class_name: :event, foreign_key: :event_id
end
