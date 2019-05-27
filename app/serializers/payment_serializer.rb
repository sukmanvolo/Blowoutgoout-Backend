class PaymentSerializer < ActiveModel::Serializer
  attributes :id, :discount_percent, :tip_fee, :discount, :amount, :service_name,
  :appointment_date, :created_at

  def created_at
    object.created_at.strftime('%m-%d-%Y %H:%M')
  end

  def service_name
    object.service.name
  end

  def appointment_date
    object.service.name
  end
end