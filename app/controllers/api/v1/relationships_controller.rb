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

      def get_follow_numbers
        @follow_numbers = User.find_by(id: params[:id]).follows
        render status: 200, json: { data: { follow_numbers: @follow_numbers } }
      end

      def get_followers_numbers
        @follower_numbers = User.find_by(id: params[:id]).followers
        render status: 200, json: { data: { follower_numbers: @follower_numbers} }
      end

      private

      def set_user
        @user = User.find_by(id: params[:follow_id])
      end
    end
  end
end