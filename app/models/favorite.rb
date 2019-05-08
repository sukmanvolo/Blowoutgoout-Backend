class Favorite < ApplicationRecord
  belongs_to :client
  belongs_to :stylist

  scope :by_client, -> (id) { includes(:stylist).where(client: id) }
end
