module Api
  module V1
    class DmMessagesController < ApplicationController
      jwt_authenticate
      before_action :set_dm_msg, only: [:destroy]
      def index
        dm_msgs = Dm.find_by(id: params[:dm_id]).dm_messages
        render status: 200, json: { dm_msgs: dm_msgs}
      end

      def create
        dm_info = dm_msg_params
        dm_info[:dm_id] = params[:dm_id]
        dms_msg = @current_user.dm_messages.new(dm_info)
        dms_msg.save
        render status: 200, json: { dms_msg: dms_msg}
      end
      def destroy
        if @dm_msg.user_id  == @current_user.id
          @dm_msg.destroy
          render 400
        else
          #invalid user
        end
      end
      private
      def set_dm_msg
        @dm_msg = DmMessage.find(params[:id])
      end
      def dm_msg_params
        params.require(:dm).permit(:message)
      end
    end
  end
end
