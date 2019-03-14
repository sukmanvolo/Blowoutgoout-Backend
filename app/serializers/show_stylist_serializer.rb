class ShowStylistSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :description, :phone, :lat,
            :long, :image

  has_many :reviews

  def image
    Rails.application.routes.url_helpers.rails_representation_url(object.image.variant(resize: "100x100").processed)
  end
end