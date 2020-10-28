module Api
  module V1
    class RelationshipsController < ApplicationController
      include JwtAuthenticator
      jwt_authenticate
      before_action :set_user

      def index
        @followings = @current_user.followings
        render status: 200, json: { data: { users: @followings } }
      end

      def create
        if @user == nil 
          render status: 500
        else 
          @following = @current_user.follow(@user)
          if @following.save
            @current_user.update_attributes(follows: @current_user.follows + 1)
            @user.update_attributes(followers: @user.followers + 1)
            render status: 201
          else
            render status: 500
          end
        end
      end

      def destroy
        @following = @current_user.unfollow(@user)
        if @following.destroy
          @current_user.update_attributes(follows: @current_user.follows - 1)
          @user.update_attributes(followers: @user.followers - 1)
          render status:204
        else
          render status:500
        end
      end

      def follow_numbers
        @user = User.find_by(id: user_params[:id])
        render status: 200, json: { data: { user: { user_id: @user.id, follows: @user.follow_number, followers: @user.follower_number } } }
      end

      def follow_index
        @followings = User.find_by(id: user_params[:id]).followings
        render status: 200, json: { data: { users: @followings } }
      end 

      private

      def set_user
        @user = User.find_by(id: params[:follow_id])
      end

      def user_params
        params.require(:user).permit(:id)
      end
    end
  end
end