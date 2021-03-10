class TagSerializer < ActiveModel::Serializer
  attributes :id,:name,:used_num

  def used_num
    object.rooms_tags.count
  end
end
