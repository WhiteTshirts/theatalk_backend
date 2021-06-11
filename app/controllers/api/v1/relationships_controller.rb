module Api
  module V1
    class RelationshipsController < ApplicationController
      jwt_authenticate
      before_action :set_user

      def index
        no_user && return
        if params[:list]=="followings"
          render status:200,json:@user.followings
        else
          render status:200,json:@user.followers
        end
      end

      def create
        no_user && return
        same_user && return
        @following = @current_user.follow(@user)
        @following.save!
        @current_user.increment!(:follow_number)
        @user.increment!(:follower_number)
        render status: 201,json: {user:@user}
      end

      def destroy
        no_user && return
        same_user && return
        @following = @current_user.unfollow(@user)
        if @following.nil?
          render status: 404
        else
          @following.destroy!
          @current_user.increment!(:follow_number, -1)
          @user.increment!(:follower_number, -1)
          render status: 204
        end

      end

      def follow_numbers
        render status: 200, json: { user: { id: @user.id, follow_number: @user.follow_number, follower_number: @user.follower_number } }
      end

      def follow_index
        @followings = User.find(user_params[:id]).followings
        print(@followings)
        render status: 200, json: { users: @followings  }
      end 

      private

      def set_user
        @user = User.find_by(id: user_params[:id])
      end
      def no_user
        if @user.nil?
          render status:404
        end
      end
      def same_user
        if @user.id == @current_user.id
          render status:405
        end
      end
      def user_params
        params.require(:user).permit(:id)
      end
    end
  end
end