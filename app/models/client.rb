class Client < ApplicationRecord
  belongs_to :user, dependent: :destroy
  has_many :favorites,
    dependent: :destroy
  has_many :favorite_stylists,
    through: :favorites, source: :stylist

  has_one_attached :image

  accepts_nested_attributes_for :user

  validates :image, presence: true, blob: { content_type: :image }

  delegate :first_name, :last_name, :phone, to: :user, prefix: false

  def image_attached?
    image.attached?
  end

  def full_name
    [last_name, first_name].join(' ')
  end
end