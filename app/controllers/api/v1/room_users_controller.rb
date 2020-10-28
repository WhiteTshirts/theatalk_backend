'''
	Author: Hiranuma Tomoyuki
	Date: 20200907
'''

module Api
	module V1
		class RoomUsersController < ApplicationController
			jwt_authenticate 
			# ルームに入室しているユーザ一覧を取得(入室した順番に取得)

			#Kyosuke Yokota
			def index 
				users = User.where(room_id: @current_user.room_id).order(updated_at: :desc)#rikuiwasaki
				render status:200, json: { message: 'Loaded posts', data: { users: users } }
			end
			#Kyosuke Yokota
			def create
				if @current_user.update_attribute(:room_id, room_id_params[:room_id])
					room = Room.find_by(id: room_id_params[:room_id])
					room.increment!(:viewer)
					render status:201, json: {  data: { user: @current_user } }
				else
					render status:500, json: {  data: { error: @current_user.errors } }
				end
			end

			def leave
				room_ = @current_user.room_id
				if @current_user.update_attribute(:room_id, nil)
					room = Room.find_by(id: room_)
					room.increment!(:viewer,-1)
					render status:204, json: { }
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
