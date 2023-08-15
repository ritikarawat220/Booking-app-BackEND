class User < ApplicationRecord
  has_many :reservations
  has_many :aeroplanes, through: :reservations
end
