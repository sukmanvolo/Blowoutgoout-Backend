class PaymentSerializer < ActiveModel::Serializer
  attributes :id, :discount_percent, :tip_fee, :discount, :amount, :services,
  :appointment_date, :payment_date

  def payment_date
    object.created_at.strftime('%Y-%m-%d %H:%M')
  end

  def services
    object.booking.services
  end

  def appointment_date
    object&.booking&.schedule&.date && object&.booking&.schedule&.date&.strftime('%Y-%m-%d %H:%M')
  end
end
