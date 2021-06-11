module Api
  module V1
    class DmMessagesController < ApplicationController
      jwt_authenticate

      # ここリファクタリングしたい
      def index
        if dm = Dm.find_by(id: params[:dm_id])
          dm.users.each do |user|
            if user == @current_user
              dm_msgs = dm.dm_messages
              render status: 200, json: dm_msgs, root: "dm_msgs", adapter: :json
              return 
            end
          end
          render status: 440 ,json: {error: "you are invalid user."}
        else
          render status: 404, json: {error: "not found"}
          return
        end
      end

      def create
        dm_info = dm_msg_params
        dm_info[:dm_id] = params[:dm_id]
        dm_msg = @current_user.dm_messages.new(dm_info)
        dm_msg.save!
        render status: 201, json: dm_msg, root: "dm_msg", adapter: :json
      end

      def destroy
        @dm_msg = DmMessage.find(params[:id])
        if @dm_msg.user_id == @current_user.id
          @dm_msg.destroy
          render 400
        else
          #invalid user
        end
      end
      
      private

      def dm_msg_params
        params.require(:dm).permit(:message)
      end
      
    end
  end
end
