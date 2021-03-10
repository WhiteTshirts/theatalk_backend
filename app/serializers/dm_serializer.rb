class DmSerializer < ActiveModel::Serializer
  type 'dms'
  attributes :id,:updated_at,:created_at
  has_many :users, serializer: UserSerializer do
    object.users.order(created_at: :desc)
  end

end
