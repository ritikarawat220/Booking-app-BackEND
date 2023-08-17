# This serializer class is responsible for converting User objects into JSONAPI format.
class UserSerializer
  include JSONAPI::Serializer
  attributes :id, :email
end

