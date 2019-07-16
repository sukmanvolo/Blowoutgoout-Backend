class AvailabilitySerializer < ActiveModel::Serializer
  attributes :id, :schedule_id, :time_from, :time_to

  def time_from
    object.time_from && object.time_from.strftime('%H:%M:%S')
  end

  def time_to
    object.time_to && object.time_to.strftime('%H:%M:%S')
  end
end