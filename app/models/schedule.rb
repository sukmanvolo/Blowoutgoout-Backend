class Schedule < ApplicationRecord
  attr_accessor :start_time

  has_many :stylist_schedules
  has_many :stylists, through: :stylist_schedules

  validates :date, presence: true

  scope :filter_by_service, ->(id) { where("service_ids @> ?", "{#{id}}") }
  scope :from_date, ->(date) { where('schedules.date > ?', date) }
  scope :to_date, ->(date) { where('schedules.date <= ?', date) }
  scope :upcoming, -> { where('schedules.date >= ?',  Date.today) }
  scope :past, -> { where('schedules.date < ?',  Date.today) }
end
