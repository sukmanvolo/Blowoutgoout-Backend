class Message < ApplicationRecord
  belongs_to :booking
  belongs_to :client
  belongs_to :stylist

  scope :by_booking, -> (id) { where(booking: id) }

  enum status: [:inactive, :active]

  validates :text, presence: true
end
