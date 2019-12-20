class Payment < ApplicationRecord
  belongs_to :booking

  has_one :client, through: :booking
  has_one :stylist, through: :booking

  validates :amount, presence: true

  enum status: [:not_paid, :paid]

  scope :by_stylist, ->(id) { where(stylist: id) }
end
