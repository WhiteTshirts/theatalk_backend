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
            @current_user.increment!(:follow_number)
            @user.increment!(:follower_number)
            render status: 201
          else
            render status: 500
          end
        end
      end

      def destroy
        @following = @current_user.unfollow(@user)
        if @following.destroy
          @current_user.increment!(:follow_number, -1)
          @user.increment!(:follower_number, -1)
          render status: 204
        else
          render status: 500
        end
      end

      def follow_numbers
        render status: 200, json: { data: { user: { id: @user.id, follow_number: @user.follow_number, follower_number: @user.follower_number } } }
      end

      def follow_index
        @followings = User.find(user_params[:id]).followings
        print(@followings)
        render status: 200, json: { data: { users: @followings } }
      end 

      private

      def set_user
        @user = User.find_by(id: user_params[:id])
      end

      def user_params
        params.require(:user).permit(:id)
      end
    end
  end
end