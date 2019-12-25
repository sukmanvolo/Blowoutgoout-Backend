class AvailabilitySerializer < ActiveModel::Serializer
  attributes :id, :start_time, :end_time

  def start_time
    object.start_time.strftime('%H:%M:%S')
  end

  def end_time
    object.end_time.strftime('%H:%M:%S')
  end
end