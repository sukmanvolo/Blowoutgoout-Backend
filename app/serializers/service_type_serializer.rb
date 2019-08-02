class ServiceSerializer < ActiveModel::Serializer
  attributes :id, :name, :status, :image

  def image
    if object.image_attached?
      Rails.application
           .routes
           .url_helpers
           .rails_representation_url(object.image.variant(resize: "100x100").processed)
    end
  end
end