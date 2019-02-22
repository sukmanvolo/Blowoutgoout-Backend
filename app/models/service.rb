class Service < ApplicationRecord
  # relantionships
  belongs_to :service_type
  belongs_to :stytlist

  # validations
  validates :name, presence: true

  # enum
  enum status: [:inactive, :active]

  # scopes
  scope :actives, -> { where(status: :active) }
end
