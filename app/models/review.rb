class Review < ApplicationRecord
  belongs_to :booking

  # enum
  enum status: [:inactive, :active]

  scope :by_client, ->(id) { where(client_id: id) }
  scope :by_stylist, ->(id) { joins(:booking).where('bookings.stylist_id = ?', id) }
  scope :by_booking, ->(id) { where(booking_id: id) }
end
