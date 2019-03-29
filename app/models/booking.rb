class Booking < ApplicationRecord
  belongs_to :client
  belongs_to :stylist
  belongs_to :service

  before_create :check_status_default

  # enum
  enum status: [:confirmed, :completed, :rejected, :pending]

  private

  def check_status_default
    return unless self.status.nil?
    self.status = 'pending'
  end
end