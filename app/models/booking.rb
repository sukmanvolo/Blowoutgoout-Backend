class Booking < ApplicationRecord
  belongs_to :client
  belongs_to :stylist
  has_many :messages
  belongs_to :schedule

  before_create :check_status_default

  # enum
  enum status: %i[confirmed completed rejected pending paid cancelled]

  validates :service_ids, :time_from, :time_to, :card_token, presence: true

  scope :by_client, ->(id) { where(client_id: id) }
  scope :by_stylist, ->(id) { where(stylist_id: id) }
  scope :upcoming, -> { where(status: %w[confirmed pending]).joins(:schedule).merge(Schedule.upcoming) }
  scope :past, -> { where(status: %w[confirmed completed]).joins(:schedule).merge(Schedule.past) }

  delegate :amount, :name, to: :service, prefix: true
  delegate :customer_id, to: :client, prefix: true

  private

  def check_status_default
    return unless status.nil?
    self.status = 'pending'
  end
end
