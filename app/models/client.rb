class Client < ApplicationRecord
  has_one_attached :image

  belongs_to :user, dependent: :destroy
  has_many :favorites,
           dependent: :destroy
  has_many :favorite_stylists,
           through: :favorites, source: :stylist
  has_many :bookings, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :messages, dependent: :destroy


  accepts_nested_attributes_for :user

  validates :image, presence: false, blob: { content_type: :image }

  delegate :email, :first_name, :last_name, :phone, to: :user, prefix: false

  def image_attached?
    image.attached?
  end

  def full_name
    [first_name, last_name].join(' ').titleize
  end

  def customer_id
    stripe_customer_id = self[:customer_id]
    unless stripe_customer_id.present?
      begin
        stripe_customer_id = Stripe::Customer.create(
          email: user.email,
          description: "Customer for #{user.email}"
        )

        update_attributes!(customer_id: stripe_customer_id.id)
      rescue StandardError => e
        puts "**** Stripe create customer error: #{e}"
      end
    end
    stripe_customer_id
  end
end
