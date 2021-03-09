class RoomSerializer < ActiveModel::Serializer
  attributes :id,:name,:admin_id,:youtube_id,:created_at,:updated_at,:viewer
  def initialize(object,options={})
    super
    @user = options[:user]
  end
  has_many :users, serializer: UserSerializer,user: @user
  has_many :tags,serializer: TagSerializer do
    object.tags.order(created_at: :desc)

  end
end
