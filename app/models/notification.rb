class Notification < ApplicationRecord
  belongs_to :user

  # enum
  enum status: [:not_sent, :sent]

  scope :by_user, ->(id) { where(user_id: id) }
end
