class ScheduleSerializer < ActiveModel::Serializer
  attributes :id, :service_ids, :date #, :stylist_id

  def date
    object.date.strftime('%Y-%m-%d')
  end
end