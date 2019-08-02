class ServiceSerializer < ActiveModel::Serializer
  attributes :id, :name, :service_type_id, :service_type, :stylist_id, :amount,
             :status, :image

  def service_type
    object.service_type_name
  end

  def image
    if object.image_attached?
      Rails.application
           .routes
           .url_helpers
           .rails_representation_url(object.image.variant(resize: "100x100").processed)
    end
  end
end