class ServiceSerializer < ActiveModel::Serializer
  attributes :id, :name, :service_type_id, :service_type, :stylist_id, :amount,
             :status

  def service_type
    object.service_type_name
  end
end