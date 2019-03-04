class Booking < ApplicationRecord
  belongs_to :client
  belongs_to :stytlist
  belongs_to :service
  belongs_to :card

  # enum
  enum status: [:confirm, :complete, :cancel, :start]
end
