module Api
  module V1
    class DmMessagesController < ApplicationController
      jwt_authenticate

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
      private
      def dm_msg_params
        params.require(:dm).permit(:message)
      end
    end
  end
end
