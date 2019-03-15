class User < ApplicationRecord
  has_secure_password
  rolify

  # validations
  validates :password, presence: true, on: :create
  validates :role, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :email, uniqueness: { scope: :role }
  validates :first_name, presence: true

  # relantionships
  has_many :user_services, -> { order(date: :asc) }
  has_many :services, through: :user_services

  has_one :client, inverse_of: :user, dependent: :destroy
  has_one :stylist, inverse_of: :user, dependent: :destroy

  # enum
  enum role: [:client, :stylist, :admin]
  enum status: [:inactive, :active]

  # callbacks
  after_create :assign_default_role

  def generate_password_token!
   self.reset_password_token = generate_token
   self.reset_password_sent_at = Time.now.utc
   save!
  end

  def password_token_valid?
   (self.reset_password_sent_at + 4.hours) > Time.now.utc
  end

  def reset_password!(password)
   self.reset_password_token = nil
   self.password = password
   save!
  end

  private

  def generate_token
    SecureRandom.hex(10)
  end

  def assign_default_role
    self.add_role(:regular) if self.roles.blank?
  end
end
