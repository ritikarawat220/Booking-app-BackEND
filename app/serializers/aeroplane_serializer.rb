class AeroplaneSerializer < ActiveModel::Serializer
  attributes :name, :model, :description, :price, :booking_price, :image
end
