# This serializer class is responsible for converting User objects into JSONAPI format.
class UserSerializer
  include JSONAPI::Serializer
  attributes :id, :email, :created_at

  attribute :created_date do |user|
    user.created_at&.strftime('%m/%d/%y')
  end
end
