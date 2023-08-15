class User < ApplicationRecord
=begin
include Devise::JWT::RevocationStrategies::JTIMatcher
=end


  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
          :validatable, jwt_authenticatable, jwt_revocation_strategy: self


  has_many :reservations
  has_many :aeroplanes, through: :reservations
end
