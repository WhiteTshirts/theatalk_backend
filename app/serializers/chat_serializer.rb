class ChatSerializer < ActiveModel::Serializer
  attributes :id,:text,:created_at,:updated_at
  belongs_to :user, serializer: UserSerializer

end
