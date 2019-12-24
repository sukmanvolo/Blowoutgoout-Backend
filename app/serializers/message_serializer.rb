class MessageSerializer < ActiveModel::Serializer
  attributes :id, :booking_id, :text, :status, :sender,
             :created_at, :updated_at, :client, :stylist

  def created_at
    object.created_at.strftime('%m-%d-%Y %H:%M:%S')
  end

  def updated_at
    object.updated_at.strftime('%m-%d-%Y %H:%M:%S')
  end

  def client
    Client.find_by_id(object&.client_id).as_json
  end

  def stylist
    Stylist.find_by_id(object&.stylist_id).as_json
  end
end
