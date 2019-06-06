class Availability < ApplicationRecord
  belongs_to :schedule
  has_one :booking

  # enum
  enum status: [:free, :reserved, :used]


  def can_delete?
    schedule.date != Date.today && schedule.date != Date.today + 1
  end
end
