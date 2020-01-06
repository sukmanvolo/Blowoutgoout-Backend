# frozen_string_literal: true

class BookingSerializer < ActiveModel::Serializer
  attributes :id, :client_id, :client_full_name,
             :date, :time_from, :time_to, :service_lat,
             :service_long, :status, :fee, :notes, :services, :stylist, :card, :rated

  belongs_to :stylist, serializer: ShowStylistSerializer

  has_many :reviews

  def rated
    object.reviews_count > 0
  end
  
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
    object.fee
  end

  def services
    object.services
  end

  def card
    CardService.new(current_user.client).show(object&.card_token)
  end
end
