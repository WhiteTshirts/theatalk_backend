class UserSerializer < ActiveModel::Serializer

  attributes :id, :name, :avatar
  def initialize(object,options={})
    super
    @user = options[:user]
    @scope = case options[:scope]
      when :detail then "detail"
      when :all then "all"
      else "base"
      end
  end

  def avatar
    object.avatar.attachment.service.send(:object_for, object.avatar.key).public_url if object.avatar.attached?
  end

  def is_following
    @user.followings.include?(object)
  end

  def is_follower
    object.followings.include?(@user)
  end

  def tags
    object.tags.order(created_at: :desc)
  end

  def rooms
    Room.where(admin_id:object.id).select(:youtube_id,:admin_id,:id,:name)
  end

  attribute :is_following, if: -> {@user != nil}
  attribute :is_follower, if: -> {@user != nil}
  attribute :room_id, if: -> { @scope=="detail" || @scope=="all"}
  attribute :profile, if: -> { @scope=="detail" || @scope=="all"}
  attribute :follow_number, if: -> {@scope=="detail"|| @scope=="all"}
  attribute :follower_number, if: -> {@scope =="detail"|| @scope=="all"}
  attribute :img_path, if: -> {@scope =="detail"|| @scope=="all"}
  attribute :followings, if: ->{@scope=="all"}
  attribute :followers, if: ->{ @scope=="all"}
  attribute :tags, if: ->{@scope=="all"}
  attribute :rooms, if: ->{@scope=="all"}
end
