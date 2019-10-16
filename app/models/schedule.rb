class Schedule < ApplicationRecord
  # belongs_to :stylist
  has_many :availabilities

  validates :date, presence: true
  has_many :stylist_schedules
  has_many :stylists, through: :stylist_schedules

  scope :filter_by_service, ->(id) { where("service_ids @> ?", "{#{id}}") }
  scope :from_date, ->(date) { where('date > ?', date) }
  scope :to_date, ->(date) { where('date <= ?', date) }
end
