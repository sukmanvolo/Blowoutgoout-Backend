class Review < ApplicationRecord
  belongs_to :stylist

  # enum
  enum status: [:inactive, :active]
end
