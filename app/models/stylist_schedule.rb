class StylistSchedule < ApplicationRecord
  belongs_to :stylist
  belongs_to :schedule

  attr_accessor :tmp_end_time

  validates :start_time, presence: true

  def available?
    available
  end
end
