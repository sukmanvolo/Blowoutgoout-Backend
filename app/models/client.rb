class Client < ApplicationRecord
  belongs_to :user, dependent: :destroy
  has_many :favorites,
    dependent: :destroy
  has_many :favorite_stylists,
    through: :favorites, source: :stylist
  has_one_attached :image

  accepts_nested_attributes_for :user

  validates :first_name, presence: true

end