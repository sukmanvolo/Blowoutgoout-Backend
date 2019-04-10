class Service < ApplicationRecord
  # relantionships
  belongs_to :service_type
  belongs_to :stylist
  has_one_attached :image

  # validations
  validates :name, :amount, presence: true

  # enum
  enum status: [:inactive, :active]

  # scopes
  scope :actives, -> { where(status: :active) }
end
