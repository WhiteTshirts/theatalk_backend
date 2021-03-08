class RoomSerializer < ActiveModel::Serializer
  attributes :id,:name,:admin_id,:youtube_id,:created_at,:updated_at,:viewer
  has_many :users, serializer: UserSerializer do
    object.users.order(created_at: :desc)
  end
end
