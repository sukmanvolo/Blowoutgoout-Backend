class ServiceType < ApplicationRecord

  # relantionships
  has_many :services, -> { order(date: :asc) }

  # validations
  validates :name, presence: true

  # enum
  enum status: [:inactive, :active]
end
