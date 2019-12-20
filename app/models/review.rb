class Review < ApplicationRecord
  belongs_to :stylist

  # enum
  enum status: [:inactive, :active]

  scope :by_client, ->(id) { where(client_id: id) }
  scope :by_stylist, ->(id) { where(stylist_id: id) }
end
