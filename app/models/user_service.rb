class UserService < ApplicationRecord
  belongs_to :user
  belongs_to :service

  validates :comments, presence: true
  validates :date, presence: true
end
