class ServiceType < ApplicationRecord

  # relantionships
  has_many :services, -> { order(date: :asc) }
  has_one_attached :image

  # validations
  validates :name, presence: true

  # enum
  enum status: [:inactive, :active]
end
