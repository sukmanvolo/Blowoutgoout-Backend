class Client < ApplicationRecord
  belongs_to :user, dependent: :destroy
  has_one_attached :image

  validates :first_name, presence: true

  accepts_nested_attributes_for :user
end