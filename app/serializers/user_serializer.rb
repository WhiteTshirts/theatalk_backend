class UserSerializer < ActiveModel::Serializer

  attributes :id,:name,:profile,:room_id,:follow_number,:follower_number
end
