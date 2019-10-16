class AvailabilitySerializer < ActiveModel::Serializer
  attributes :id, :start_time

  def start_time
    object.start_time.strftime('%H:%M:%S')
  end
end