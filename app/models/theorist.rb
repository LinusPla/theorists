class Theorist < ApplicationRecord
  belongs_to :user
  has_many :bookings
  has_many :reviews
  has_one_attached :photo

  include PgSearch::Model
  pg_search_scope :search_by_stage_name_and_main_theory,
    against: [ :stage_name, :main_theory ],
    using: {
      tsearch: { prefix: true }
    }
end
