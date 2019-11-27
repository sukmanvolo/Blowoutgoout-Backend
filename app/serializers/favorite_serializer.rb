class FavoriteSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :email, :phone, :lat, :long, :image,
             :ratings, :is_favorite

  def id
    object.stylist.id
  end

  def first_name
    object.stylist.first_name
  end

  def last_name
    object.stylist.last_name
  end

  def email
    object&.stylist&.user&.email
  end

  def phone
    object&.stylist&.user&.phone
  end

  def lat
    object&.stylist&.lat
  end

  def long
    object&.stylist&.long
  end

  def is_favorite
    current_user&.client&.favorites&.map(&:stylist_id)&.include?(object&.stylist&.id)
  end

  def image
    return nil unless object&.stylist&.image_attached?
    
    if object&.stylist&.image&.variable?
      Rails.application
           .routes
           .url_helpers
           .rails_representation_url(object&.stylist&.image&.variant(resize: "100x100")&.processed)
    else
      Rails.application
           .routes
           .url_helpers
           .url_for(object&.stylist&.image)
    end
  end

  def ratings
    {
      count: object&.stylist&.reviews_count,
      rating: object&.stylist&.reviews_rating
    }
  end
end
