class PaymentDataSerializer < ActiveModel::Serializer
  attributes :id, :payment_date, :booking_date,
             :client_first_name, :client_last_name

  def payment_date
    object.created_at.strftime('%Y-%m-%d %H:%M')
  end

  def booking_date
    object&.booking&.date.strftime('%Y-%m-%d %H:%M')
  end

  def client_first_name
    object&.booking&.client&.first_name
  end

  def client_last_name
    object&.booking&.client&.last_name
  end
end
