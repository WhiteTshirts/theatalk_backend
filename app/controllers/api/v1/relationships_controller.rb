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
            render status: 201
          else
            render status: 500
          end
        end
      end

      def destroy
        @following = @current_user.unfollow(@user)
        if @following.destroy
          render status:204
        else
          render status:500
        end
      end

      def get_follow_numbers
        @followings = User.find_by(id: params[:id]).followings
        render status: 200, json: { data: { user: @followings.length } }
      end

      private

      def set_user
        @user = User.find_by(id: params[:follow_id])
      end
    end
  end
end