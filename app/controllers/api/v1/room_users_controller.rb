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
				users = User.where(room_id: @current_user.room_id).order(updated_at: :desc)#rikuiwasaki
				render status:200, json: { message: 'Loaded posts', data: { users: users } }
			end
			def create
				pre_room_id = @current_user.room_id
				if @current_user.update_attribute(:room_id, room_id_params[:room_id])
					if pre_room_id != room_id_params[:room_id]
						info = { type:"add",user:{id:@current_user.id,name:@current_user.name}}
						users = User.where(room_id: room_id_params[:room_id]).select(:id,:name)
						RoomChannel.broadcast_to("room_#{room_id_params[:room_id]}",info)
					  room = Room.find_by(id: room_id_params[:room_id])
						room.increment!(:viewer)
						render status:201, json: { data: { users: users } }
					else
						render status:200, json:{ data:{}}
					end
				else
					render status:500, json: { data: { error: @current_user.errors } }
				end
			end
			def leave
				room_id = @current_user.room_id
				if @current_user.update_attribute(:room_id, nil)
					if room_id.nil?
						render status:404, json: { data: {}}
					else
					  room = Room.find_by(id: room_id)
						room.increment!(:viewer,-1)
						info = { type:"del",user:{id:@current_user.id,name:@current_user.name}}
						RoomChannel.broadcast_to("room_#{room_id_params[:room_id]}",info)
						render status:204, json: { data:{}}
					end
				else
					render status:500, json: { data: { error: @current_user.errors } }
				end
			end
			private
			def room_id_params
				params.require(:user).permit(:room_id)
			end
		end
	end
end
