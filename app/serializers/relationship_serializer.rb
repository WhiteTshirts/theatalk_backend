class RelationshipSerializer < ActiveModel::Serializer
  attributes :user_id,:follow_id

  belongs_to :user, serializer: UserSerializer
  belongs_to :follow, class_name: 'User'

end
