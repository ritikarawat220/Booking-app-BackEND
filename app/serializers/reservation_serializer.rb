class ReservationSerializer < ActiveModel::Serializer
  attributes :id, :reservation_date, :returning_date, :city
end
