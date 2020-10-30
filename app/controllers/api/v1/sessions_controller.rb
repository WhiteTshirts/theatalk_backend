module Api
  module V1
    class SessionsController < ApplicationController
      include JwtAuthenticator

      def create
        @current_user = User.select(:id, :name, :profile, :password_digest).find_by(name: user_params[:name])
        if @current_user && @current_user.authenticate(user_params[:password])
          jwt_token = encode(@current_user.id)
          response.headers['X-Authentication-Token'] = jwt_token
          render status:200, json: { data: { user: @current_user,token: jwt_token } }
        else
          render status:401
        end
      end
      
      def user_params
        params.require(:user).permit(:name,:password)
      end
    end
  end
end
