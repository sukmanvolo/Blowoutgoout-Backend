class ScheduleSerializer < ActiveModel::Serializer
  attributes :id, :stylist_id ,:service_id ,:date

  def date
    object.date.strftime('%m-%d-%Y')
  end
end