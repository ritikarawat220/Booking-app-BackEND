# This class represents an aeroplane in the application.
class Aeroplane < ApplicationRecord
  has_many :reservations
  has_many :users, through: :reservations
end
