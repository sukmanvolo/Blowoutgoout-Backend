class Stylist < ApplicationRecord
  has_one_attached :image
  has_one_attached :cosmetology_license
  has_one_attached :liability_insurance
  has_one_attached :eligibility_document

  # relantionships
  belongs_to :user, dependent: :destroy
  has_many :services
  has_many :schedules
  has_many :reviews
  has_many :favorites, dependent: :destroy

  # emun welcome_kit: [] ask for values
  enum service_type: [:hair, :makeup, :hair_and_makeup]
  enum register_by: [:normal, :facebook]
  enum years_of_experience: ['junior', 'semi-senior', 'senior']
  enum has_smartphone: [:no, :iphone, :android]

  accepts_nested_attributes_for :user

  acts_as_mappable :default_units => :kms,
                   :default_formula => :sphere,
                   :distance_field_name => :distance,
                   :lat_column_name => :lat,
                   :lng_column_name => :long

  validates :image, presence: false, blob: { content_type: :image }
  validates :cosmetology_license, presence: false, blob: { content_type: ['image/png', 'image/jpg', 'image/jpeg', 'application/pdf'] }
  validates :liability_insurance, presence: false, blob: { content_type: ['image/png', 'image/jpg', 'image/jpeg', 'application/pdf'] }
  validates :eligibility_document, presence: false, blob: { content_type: ['image/png', 'image/jpg', 'image/jpeg', 'application/pdf'] }

  DISTANCE = 20

  scope :actives, -> { joins(:user).where( users: { status: :active } )}
  scope :nearest_stylists, ->(lat, long) { actives.within(DISTANCE, origin: [lat, long]) }
  delegate :first_name, :last_name, :phone, to: :user, prefix: false

  def image_attached?
    image.attached?
  end

  def cosmetology_license_attached?
    cosmetology_license.attached?
  end

  def liability_insurance_attached?
    liability_insurance.attached?
  end

  def eligibility_document_attached?
    eligibility_document.attached?
  end

  def full_name
    [first_name, last_name].join(' ').titleize
  end

  def reviews_count
    reviews.count
  end

  def reviews_rating
    return 0 unless reviews_count > 0
    (reviews.sum(&:rate) / reviews_count).round(1)
  end
end