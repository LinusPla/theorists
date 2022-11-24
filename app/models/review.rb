class Review < ApplicationRecord
  belongs_to :user
  belongs_to :theorist
  # validates :booking_date, :comment, :rating, presence: true
  # validates :rating, numericality: { only_integer: true}
  # validates :rating, acceptance: { accept: [1, 2, 3, 4, 5] }
end
