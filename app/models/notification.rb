class Notification < ApplicationRecord
  belongs_to :user

  # enum
  enum status: [:not_sent, :sent]

end
