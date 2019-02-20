class Service < ApplicationRecord
  # scopes
  scope :actives, -> { where(active: true) }

  # validations
  validates :name, presence: true

  # relantionships
  belongs_to :service_type
  belongs_to :stytlist

  # enum
  enum status: [:inactive, :active]
end
