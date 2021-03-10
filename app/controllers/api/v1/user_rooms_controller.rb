module Api
  module V1
    class UserRoomsController < ApplicationController
      include JwtAuthenticator
      jwt_authenticate
      def index
        if user = User.find_by(id:params[:user_id])
          rooms = Room.where(admin_id:user.id)
          render status:200,json: rooms,include: '**', user: @current_user
        else
          render status:404
        end
      end
    end
  end
end
