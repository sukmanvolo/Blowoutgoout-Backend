class ServiceType < ApplicationRecord
  belongs_to :stylist

  has_one_attached :image

  # relantionships
  has_many :services, -> { order(date: :asc) }

  # validations
  validates :name, presence: true

  # enum
  enum status: [:inactive, :active]


  def image_attached?
    image.attached?
  end
end
