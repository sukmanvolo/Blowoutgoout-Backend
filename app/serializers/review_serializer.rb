class ReviewSerializer < ActiveModel::Serializer
  attributes :id, :text, :rate, :booking_id, :status, :client, :stylist

  def client
    client.find_by_id(object&.client).as_json
  end

  def stylist
    Stylist.find_by_id(object&.booking&.stylist_id).as_json
  end
end