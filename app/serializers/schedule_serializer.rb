class ScheduleSerializer < ActiveModel::Serializer
  attributes :id, :service_ids, :date

  def date
    object.date.strftime('%Y-%m-%d')
  end
end