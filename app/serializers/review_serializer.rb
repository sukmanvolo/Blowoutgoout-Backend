class ReviewSerializer < ActiveModel::Serializer
  attributes :id, :text, :rate, :stylist_id, :client_id, :status

end