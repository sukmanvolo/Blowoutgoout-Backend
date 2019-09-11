class FavoriteSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :email, :phone, :lat, :long, :image,
             :reviews

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

  def email
    object&.user.email
  end

  def reviews
    {
      count: object.reviews_count,
      rating: object.reviews_rating
    }
  end
end