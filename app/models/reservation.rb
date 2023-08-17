# This class represents a reservation made by a user for an aeroplane.
class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :aeroplane

  validates :reservation_date, presence: true
  validates :returning_date, presence: true
  validates :city, presence: true
end
