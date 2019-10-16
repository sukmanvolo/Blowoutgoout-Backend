class StylistSchedule < ApplicationRecord
  belongs_to :stylist
  belongs_to :schedule

  validates :start_time, presence: true
end
