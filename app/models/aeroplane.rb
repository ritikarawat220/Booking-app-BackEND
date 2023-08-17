# This class represents an aeroplane in the application.
class Aeroplane < ApplicationRecord
  has_many :reservations, dependent: :destroy
  has_many :users, through: :reservations
  validates :name, presence: true
  validates :model, presence: true
  validates :description, presence: true
  validates :price, presence: true
  validates :booking_price, presence: true
  validates :image, presence: true
end
