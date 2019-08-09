class MessageSerializer < ActiveModel::Serializer
  attributes :id, :booking_id, :client_id, :stylist_id, :text, :status,
             :created_at, :updated_at

  def created_at
    object.created_at.strftime('%m-%d-%Y %H:%M:%S')
  end

  def updated_at
    object.updated_at.strftime('%m-%d-%Y %H:%M:%S')
  end
end