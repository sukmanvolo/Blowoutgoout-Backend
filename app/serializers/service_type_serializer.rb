class ServiceTypeSerializer < ActiveModel::Serializer
  attributes :id, :name, :status, :image

  def image
    if object.image_attached?
      if object.image.variable?
        Rails.application
             .routes
             .url_helpers
             .rails_representation_url(object.image.variant(resize: "100x100").processed)
      else
        Rails.application
               .routes
               .url_helpers
               .url_for(object.image)
      end
    end
  end
end