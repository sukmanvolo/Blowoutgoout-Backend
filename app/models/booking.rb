class Booking < ApplicationRecord
  belongs_to :client
  belongs_to :stylist
  has_many :messages
  belongs_to :schedule

  before_create :check_status_default

  # enum
  enum status: [:confirmed, :completed, :rejected, :pending]

  scope :by_client, ->(id) { where(client_id: id) }
  scope :by_stylist, ->(id) { where(stylist_id: id) }
  scope :upcoming, -> { where(status: ['confirmed', 'pending']).where('date > ?',  Date.today) }
  scope :past, -> { where(status: ['confirmed', 'completed']).where('date < ?',  Date.today) }

  delegate :amount, :name, to: :service, prefix: true
  delegate :customer_id, to: :client, prefix: true

  private

  def check_status_default
    return unless self.status.nil?
    self.status = 'pending'
  end

end