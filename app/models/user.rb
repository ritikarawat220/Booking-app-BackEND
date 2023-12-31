# This class represents a user in the application.
class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher

  devise :database_authenticatable, :registerable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self

  has_many :reservations
  has_many :aeroplanes, through: :reservations, dependent: :destroy

  validates_presence_of :name, :email, :password, :password_confirmation
end
