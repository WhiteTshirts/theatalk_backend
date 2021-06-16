module Api
  module V1
    class UserRoomsController < ApplicationController
      jwt_authenticate

      def index
        user = User.find_by(id: params[:user_id])
        rooms = Room.where(admin_id: user.id)
        render status: 200, json: rooms,include: '**', user: @current_user
      end
      
    end
  end
end
