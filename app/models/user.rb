class User < ApplicationRecord
  has_secure_password

  # validations
  validates :password, presence: true, on: :create, allow_nil: true
  validates :role, presence: true, on: :create
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :email, uniqueness: { scope: :role }
  validates :first_name, presence: true

  has_one :client, inverse_of: :user, dependent: :destroy
  has_one :stylist, inverse_of: :user, dependent: :destroy
  has_many :notifications

  # enum
  enum role: [:client, :stylist, :admin]
  enum status: [:inactive, :active]

  # callbacks

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

  def full_name
    [first_name, last_name].join(' ').titleize
  end

  private

  def generate_token
    SecureRandom.hex(10)
  end
end
