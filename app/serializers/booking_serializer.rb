class BookingSerializer < ActiveModel::Serializer
  attributes :id, :client_id, :client_full_name, :stylist_id,
             :stylist_full_name, :time_from, :time_to, :service_lat,
             :service_long, :date, :status, :service_ids, :card

  def client_full_name
    object&.client&.full_name
  end

  def stylist_full_name
    object&.stylist&.full_name
  end

  def time_from
    object.time_from&.to_s(:time)
  end

  def time_to
    object.time_to&.to_s(:time)
  end

  def service_ids
    object&.schedule&.service_ids
  end

  def card
    CardService.new(current_user.client).show(object&.card_token)
  end

end
