class AeroplaneSerializer
  include JSONAPI::Serializer
  attributes :name, :model, :description, :price, :booking_price, :image
end
