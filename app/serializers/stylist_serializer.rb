class StylistSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :email, :phone, :lat, :long, :image,
             :reviews, :is_favorite

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
      count: object.bookings_reviews_count,
      rating: object.bookings_reviews_rating
    }
  end

  def is_favorite
    object.is_favorite?(object.tmp_client_id)
  end
end