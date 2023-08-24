# This class represents a reservation made by a user for an aeroplane.
class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :aeroplane

  validates :reservation_date, presence: true
  validates :returning_date, presence: true
  validates :returning_date, comparison: { greater_than_or_equal_to: :reservation_date }
  validates :city, presence: true
end
