class ScheduleSerializer < ActiveModel::Serializer
  attributes :id, :service_ids, :date

  has_many :stylist_schedules, serializer: StylistScheduleSerializer

  def date
    object.date.strftime('%Y-%m-%d')
  end
end