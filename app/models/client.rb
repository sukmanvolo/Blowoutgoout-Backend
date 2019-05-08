class Client < ApplicationRecord
  has_one_attached :image

  belongs_to :user, dependent: :destroy
  has_many :favorites,
    dependent: :destroy
  has_many :favorite_stylists,
    through: :favorites, source: :stylist

  accepts_nested_attributes_for :user

  validates :image, presence: true, blob: { content_type: :image }

  delegate :first_name, :last_name, :phone, to: :user, prefix: false

  def image_attached?
    image.attached?
  end
end