class Message < ApplicationRecord
  belongs_to :booking, optional: true
  belongs_to :client
  belongs_to :stylist

  scope :by_booking, ->(id) { where(booking: id) }
  scope :conversation, ->(client, stylist) { where(client: client, stylist: stylist, booking: nil) }

  enum status: %i[inactive active]
  enum sender: %i[client stylist admin]

  validates :text, presence: true
end
