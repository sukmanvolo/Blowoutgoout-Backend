class User < ApplicationRecord
  has_secure_password
  rolify
  # validations
  # validates :password, length: { minimum: 6 }, if: -> { new_record? || changes[:crypted_password] }
  # validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  # validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }

  validates :email, uniqueness: true

  # callbacks  
  after_create :assign_default_role

  private  
  def assign_default_role
    self.add_role(:regular) if self.roles.blank?
  end  
end
