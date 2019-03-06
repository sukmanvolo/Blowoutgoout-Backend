class ClientSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :phone, :image

  def image
    # Rails.application.routes.url_helpers.rails_blob_path(object.image)
    # object.image.variant(resize: "100x100").processed.service_url
    # Rails.application.routes.url_helpers.rails_blob_path(object.image.variant(resize: "100x100"))
    Rails.application.routes.url_helpers.rails_representation_url(object.image.variant(resize: "100x100").processed)
  end
end