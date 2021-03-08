module Api
  module V1
    class RoomHistoriesController < ApplicationController
      jwt_authenticate
      def index
        render status:200, json:{room_histories:@current_user.room_histories.order(updated_at: "DESC")}
      end
      def create
        if room = Room.find_by(id: room_params[:id])
          if room_history = @current_user.room_histories.find_by(room_id:room_params[:id])
            room_history.touch
            render status:200, json:{ room_history:room_history}
          else
            room_history = RoomHistory.new(room_id:room_params[:id],user_id:@current_user.id)
            room_history.save
            render status:201, json:{ room_history:room_history}
          end

        else
          render status 404, json:{error:"not found room"}
        end
      end
      def update
      end
      def room_params
        params.require(:room).permit(:id)
      end
    end
  end
end
