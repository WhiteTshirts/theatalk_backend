class DmMessageSerializer < ActiveModel::Serializer
  type 'dm_message'
  attributes :updated_at,:created_at,:message
  belongs_to :user, serializer: UserSerializer 
end
