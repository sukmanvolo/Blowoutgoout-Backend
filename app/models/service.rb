class Service < ApplicationRecord
  has_one_attached :image

  belongs_to :service_type
  has_many :stylist_services
  has_many :stylists, through: :stylist_services
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

  def as_json(options = {})
    super(options).merge({
      'service_type' => service_type.name
    })
  end
end
