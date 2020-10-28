'''
	Author: Hiranuma Tomoyuki
	Date: 20200907
'''

module Api
	module V1
		class RoomUsersController < ApplicationController
			jwt_authenticate 
			# ルームに入室しているユーザ一覧を取得(入室した順番に取得)

			def index 
				users = User.where(room_id: @current_user.room_id).order(updated_at: :desc)
				render status:200, json: { message: 'Loaded posts', data: { users: users } }
			end
			def create
				if @current_user.update_attribute(:room_id, room_id_params[:room_id])
					info = { type:"add",user:{id:@current_user.id,name:@current_user.name}}
					users = User.where(room_id: room_id_params[:room_id]).select(:id,:name)
					render status:201, json: { data: { users: users } }
					RoomChannel.broadcast_to("room_#{room_id_params[:room_id]}",info)
				else
					render status:500, json: { data: { error: @current_user.errors } }
				end
			end

			def leave
				if @current_user.update_attribute(:room_id, nil)
					
					RoomChannel.broadcast_to("room_#{room_id_params[:room_id]}",info)
					render status:204, json: { status: "SUCCESS", data: {} }
				else
					render status:500, json: { status: "ERROR", data: { error: @current_user.errors } }
				end
			end
			
			private
			def room_id_params
				params.require(:user).permit(:room_id)
			end

		end
	end
end
