class Stylist < ApplicationRecord
  belongs_to :user, dependent: :destroy
  has_one_attached :image

  # relantionships
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

  DISTANCE = 20

  scope :actives, -> { joins(:user).where( users: { status: :active } )}
  scope :nearest_stylists, ->(lat, long) { actives.within(DISTANCE, origin: [lat, long]) }
  delegate :first_name, :last_name, :phone, to: :user, prefix: false

  def image_attached?
    image.attached?
  end
end