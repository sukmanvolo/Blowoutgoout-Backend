class GalleryImagesStylistSerializer < ActiveModel::Serializer
  attributes :id, :email, :gallery_images

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

  def email
    object&.user.email
  end
end