module Api
  module V1
    class RoomHistoriesController < ApplicationController
      jwt_authenticate

      def index
        rooms = Room.joins(:room_histories).order('room_histories.updated_at desc')
        render status: 200, json: rooms, include: '**', user: @current_user
      end

      def create
        room = Room.find_by(id: room_params[:id])
        if room_history = @current_user.room_histories.find_by(room_id:room_params[:id])
          room_history.touch
          render status: 200, json: { room_history:room_history}
        else
          room_history = RoomHistory.new(room_id:room_params[:id],user_id:@current_user.id)
          room_history.save
          render status: 201, json:{ room_history:room_history}
        end
      end
      
      def update
      end

      private

      def room_params
        params.require(:room).permit(:id)
      end

    end
  end
end
