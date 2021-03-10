class RelationshipSerializer < ActiveModel::Serializer
  attributes :user_id,:follow_id

  belongs_to :user, serializer: UserSerializer, user: :base
  belongs_to :follow, class_name: 'User'

end
