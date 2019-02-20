class Stylist < ApplicationRecord
  belongs_to :user

  validates :first_name, presence: true

  # relantionships
  has_many :services

  # emun welcome_kit: [] ask for values
  enum service_type: [:hair, :makeup, :hair_and_makeup]
  enum register_by: [:normal, :facebook]

  accepts_nested_attributes_for :user
end