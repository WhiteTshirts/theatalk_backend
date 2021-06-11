module Api
  module V1
    class UsersController < ApplicationController
      jwt_authenticate except: [:create]
      
      def index 
        users = User.all
        render status: 200, json: users, user: @current_user, scope: :detail
      end

      def show
        user = User.find_by(id: params[:id])
        render status: 200, json: user, user: @current_user, scope: :all
      end

      def create
        @user = User.new(user_params)
        if @user.save
          jwt_token = encode(@user.id)
          response.headers['X-Authentication-Token'] = jwt_token
          render status: 201, json: { user: @user, token: jwt_token  }
        else
          render status: 409, json:{user:@user.errors}
        end
      end

      def update
        @current_user.update_attributes!(user_params)
        render status: 200, json: { user: @user  }
      end

      private

      def user_params
        params.require(:user).permit(:name, :profile, :room_id, :password)
      end

    end
  end
end

