# frozen_string_literal: true

class BookingSerializer < ActiveModel::Serializer
  attributes :id, :client_id, :client_full_name,
             :date, :time_from, :time_to, :service_lat,
             :service_long, :status, :fee, :services, :stylist, :card

  belongs_to :stylist, serializer: ShowStylistSerializer

  def client_full_name
    object&.client&.full_name
  end

  def date
    object&.schedule&.date
  end

  def time_from
    object.time_from&.to_s(:time)
  end

  def time_to
    object.time_to&.to_s(:time)
  end

  def fee
    f = 0.0
    object&.schedule&.service_ids&.each do |service_id|
      f += Service.find(service_id).amount
    end
    f
  end

  def services
    srvs = []
    object&.schedule&.service_ids&.each do |service_id|
      srvs << Service.find(service_id).as_json
    end
    srvs
  end

  def card
    CardService.new(current_user.client).show(object&.card_token)
  end
end
