class ShowStylistSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :description, :phone, :lat,
            :long, :image, :is_favorite, :cosmetology_license, :liability_insurance,
            :eligibility_document, :gallery_images, :rating

  has_many :reviews

  def ratings
    {
      count: object&.reviews_count,
      rating: object&.reviews_rating
    }
  end

  def is_favorite
    current_user&.client&.favorites&.map(&:stylist_id)&.include?(object.id)
  end

  def image
    return nil unless object.image_attached?

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

  def gallery_images
    images = []
    object.gallery_images.each do |image|
      if image.variable?
        images << {
                    id: image.id,
                    url: Rails.application
                              .routes
                              .url_helpers
                              .rails_representation_url(image.variant(resize: "100x100").processed)
                  }
      else
        images << {
                    id: image.id,
                    url: Rails.application
                              .routes
                              .url_helpers
                              .url_for(image)
                   }

      end
    end
    return images
  end

  def cosmetology_license
    return nil unless object.cosmetology_license_attached?
      Rails.application
           .routes
           .url_helpers
           .rails_representation_url(object.cosmetology_license.variant(resize: "100x100").processed)
  end

  def liability_insurance
    return nil unless object.liability_insurance_attached?
      Rails.application
           .routes
           .url_helpers
           .rails_representation_url(object.liability_insurance.variant(resize: "100x100").processed)
  end

  def eligibility_document
    return nil unless object.eligibility_document_attached?
      Rails.application
           .routes
           .url_helpers
           .rails_representation_url(object.eligibility_document.variant(resize: "100x100").processed)
  end
end
