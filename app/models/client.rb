class Client < ApplicationRecord
  belongs_to :user, dependent: :destroy
  has_many :favorites,
    dependent: :destroy
  has_many :favorite_stylists,
    through: :favorites, source: :stylist

  has_one_attached :image

  accepts_nested_attributes_for :user

  delegate :first_name, :last_name, :phone, to: :user, prefix: false

  def image_attached?
    image.attached?
  end
end