class ReviewSerializer < ActiveModel::Serializer
  attributes :id, :text, :rate, :booking_id, :status, :client, :stylist

  belongs_to :client, serializer: ClientSerializer
  
  def stylist
    Stylist.find_by_id(object&.booking&.stylist_id).as_json
  end
end