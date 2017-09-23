class Search::Event < Search::Base
  ATTRIBUTES = %i(
    name
    event_date
    address
    description
  )
  attr_accessor(*ATTRIBUTES)

  def matches
    t = ::Event.arel_table
    results = ::Event.all
    p 'name'
    p name
    results = results.where(contains(t[:name], name)) if name.present?
    results = results.where(contains(t[:event_date], event_date)) if event_date.present?
    results = results.where(contains(t[:address], address)) if address.present?
    results = results.where(contains(t[:description], description)) if description.present?
    results
  end
end