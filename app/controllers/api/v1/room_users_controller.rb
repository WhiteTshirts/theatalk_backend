
module Api
	module V1
		class RoomUsersController < ApplicationController
			jwt_authenticate 
			# ルームに入室しているユーザ一覧を取得(入室した順番に取得)

			def index 
				users = User.join(:relationship).where(room_id: @current_user.room_id).order(updated_at: :desc)
				render status: 200, json: users,include: '**',user: @current_user, adapter: :json
			end

			def create
				pre_room_id = @current_user.room_id
				if @current_user.update_attribute(:room_id, room_id_params[:room_id])
					if pre_room_id != room_id_params[:room_id]
						if room_history = @current_user.room_histories.find_by(room_id:room_id_params[:room_id])
							room_history.touch
						else
							room_history = RoomHistory.new(room_id:room_id_params[:room_id],user_id:@current_user.id)
							room_history.save
						end
						info = { type: "add", user: { id: @current_user.id, name: @current_user.name } }
						users = User.where(room_id: room_id_params[:room_id])
						RoomChannel.broadcast_to("room_#{room_id_params[:room_id]}", info)
						room = Room.find_by(id: room_id_params[:room_id])
						room.increment!(:viewer)
						render status: 201, json: {room_history:room_history} #users,root: "users", adapter: :json
					else
						render status: 200
					end
				else
					render status: 500, json: { error: @current_user.errors  }
				end
			end

			def leave
				render status: 204
				# room_id = @current_user.room_id
				# if @current_user.update_attribute(:room_id, nil)
				# 	if room_id.nil?
				# 		render status: 404
				# 	else
				# 	  room = Room.find_by(id: room_id)
				# 		room.increment!(:viewer, -1)
				# 		info = { type: "del",user:{id: @current_user.id, name: @current_user.name}}
				# 		#RoomChannel.broadcast_to("room_#{@current_user.room_id}", info)
				# 		render status: 204
				# 	end
				# else
				# 	render status: 500, json: { error: @current_user.errors }
				# end
			end

			def get_num
				room = RoomsTag.where(tag_id: params[:tags][:id])&.count
				render status: 200, json: { users_num: room }
			end
			private
			def room_id_params
				params.require(:user).permit(:room_id)
			end
		end
	end
end
