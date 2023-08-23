# This serializer class is responsible for converting User objects into JSONAPI format.
class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email
end
