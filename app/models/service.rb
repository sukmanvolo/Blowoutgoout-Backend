class Service < ApplicationRecord
  # scopes
  scope :actives, -> { where(active: true) }
  # enum
  enum service_type: { hair: 0, makeup: 1, hair_makeupnormal: 2 }

  # validations
  validates :name, presence: true
  validates :service_type, presence: true
  validates :active, presence: true

  # relantionships
  has_many :user_services, -> { order(date: :asc) }
  has_many :users, through: :user_services
end
