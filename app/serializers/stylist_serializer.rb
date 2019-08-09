class StylistSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :email, :phone, :lat, :long, :image

  def image
    if object.image_attached?
      Rails.application
           .routes
           .url_helpers
           .rails_representation_url(object.image.variant(resize: "100x100").processed)
    end
  end

  def email
    object&.user.email
  end
end