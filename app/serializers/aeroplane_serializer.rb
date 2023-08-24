class AeroplaneSerializer < ActiveModel::Serializer
  attributes :id, :name, :model, :description, :price, :booking_price, :image
end
