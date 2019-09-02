class Schedule < ApplicationRecord
  belongs_to :stylist
  has_many :availabilities

  validates :date, presence: true

  scope :filter_by_stylist, ->(id) { where(stylist: id) }
  scope :filter_by_service, ->(id) { where("service_ids @> ?", "{#{id}}") }
  scope :from_date, ->(date) { where('date > ?', date) }
  scope :to_date, ->(date) { where('date <= ?', date) }
end
