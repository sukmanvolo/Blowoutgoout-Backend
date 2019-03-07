class Availability < ApplicationRecord
  belongs_to :schedule

  # enum
  enum status: [:free, :used]

  scope :free, -> { where(status: :free ) }
end
