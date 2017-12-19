class SessionSerializer < ActiveModel::Serializer
  attributes :api_token
  has_one :user
end
