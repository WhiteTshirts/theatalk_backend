class UserSerializer < ActiveModel::Serializer

  attributes :id,:name
  def initialize(object,options={})
    super
    @user = options[:user]
    @scope = case options[:scope]
      when :detail then "detail"
      else "base"
      end

  end
  def is_following
    @user.followings.include?(object)
  end
  def is_follower
    object.followings.include?(@user)
  end
  attribute :is_following, if: -> {@user != nil}
  attribute :is_follower, if: -> {@user != nil}
  attribute :room_id, if: -> { @scope=="detail" }
  attribute :profile, if: -> { @scope=="detail" }
  attribute :follow_number, if: -> {@scope=="detail"}
  attribute :follower_number, if: -> {@scope =="detail"}
  attribute :img_path, if: -> {@scope =="detail"}

end
