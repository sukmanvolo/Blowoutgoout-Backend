class StylistScheduleSerializer < ActiveModel::Serializer
  attributes :id, :stylist_id, :schedule_id, :created_at, :updated_at,
             :start_time, :end_time, :available

  def start_time
    object.start_time.strftime('%H:%M:%S')
  end

  def end_time
    object.end_time.strftime('%H:%M:%S')
  end

  def created_at
    object.created_at.strftime('%H:%M:%S')
  end

  def updated_at
    object.updated_at.strftime('%H:%M:%S')
  end
end