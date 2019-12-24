class MessageSerializer < ActiveModel::Serializer
  attributes :id, :booking_id, :text, :status, :sender,
             :created_at, :updated_at, :client, :stylist

  belongs_to :stylist, serializer: ShowStylistSerializer
  belongs_to :client, serializer: ClientSerializer

  def created_at
    object.created_at.strftime('%m-%d-%Y %H:%M:%S')
  end

  def updated_at
    object.updated_at.strftime('%m-%d-%Y %H:%M:%S')
  end
end
