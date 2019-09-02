class ScheduleSerializer < ActiveModel::Serializer
  attributes :id, :stylist_id ,:service_ids ,:date

  def date
    object.date.strftime('%Y-%m-%d')
  end
end