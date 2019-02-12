class Client < ApplicationRecord
  belongs_to :user

  validates :first_name, presence: true

  accepts_nested_attributes_for :user
end