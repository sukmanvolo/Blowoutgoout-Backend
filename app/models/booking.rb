class Booking < ApplicationRecord
  belongs_to :client
  belongs_to :stylist
  has_many :messages, dependent: :destroy
  belongs_to :schedule
  has_one :payment
  has_many :reviews

  before_create :check_status_default

  # enum
  enum status: %i[confirmed completed rejected pending paid cancelled]

  validates :service_ids, :time_from, :time_to, :card_token, presence: true
  validate :check_valid_date

  scope :by_client, ->(id) {where(client_id: id)}
  scope :by_stylist, ->(id) {where(stylist_id: id)}
  scope :upcoming, -> {where(status: %w[confirmed pending]).joins(:schedule).merge(Schedule.upcoming)}
  scope :past, -> {where(status: %w[confirmed completed]).joins(:schedule).merge(Schedule.past)}

  delegate :amount, :name, to: :service, prefix: true
  delegate :customer_id, to: :client, prefix: true

  def services
    return [] unless service_ids.present?

    response = []
    service_ids.each do |service_id|
      response << Service.find(service_id).as_json
    end

    response
  end

  def reviews_count
    reviews.count
  end

  def reviews_rating
    return 0 unless reviews_count > 0
    (reviews.sum(&:rate) / reviews_count).round(1)
  end

  def stylist_schedule
    StylistSchedule.where(stylist_id: stylist_id,
                          schedule_id: schedule_id,
                          start_time: time_from).first
  end

  private

  def check_status_default
    return unless status.nil?
    self.status = 'pending'
  end

  def check_valid_date
    if self.date && self.date < Date.today
      self.errors.add(:date, :invalid, message: "you cannot make a booking for a past date")
    end
  end
end
