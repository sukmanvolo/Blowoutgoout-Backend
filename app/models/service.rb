class Service < ApplicationRecord
  has_one_attached :image

  belongs_to :service_type
  # belongs_to :stylist
  # has_many :schedules

  # validations
  validates :name, :amount, :duration, presence: true

  # enum
  enum status: [:inactive, :active]

  # scopes
  scope :actives, -> { where(status: :active) }

  delegate :name, to: :service_type, prefix: true

  def image_attached?
    image.attached?
  end
end
