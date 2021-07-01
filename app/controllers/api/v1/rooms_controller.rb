module Api
	module V1
		class RoomsController < ApplicationController
			jwt_authenticate 

			def index
				rooms = Room.all.order(created_at: :desc)
				render status: 200, json: rooms, include: '**', user: @current_user
			end

			def create
				room_info = room_params
				room_info[:admin_id] = @current_user.id
				room_info[:viewer] = 0
				room = Room.new(room_info)
				# TODO: 要リファクタリング
				room.save!
				@current_user.update_attributes!(room_id: room.id)
				tags_params[:tags].each do |t|
					room_tag = RoomsTag.new(room_id: room.id, tag_id: t[:id])
					room_tag.save!
				end
				render status: 201, json: room, include:'**', user: @current_user
			end
			
			def update
				room = Room.find_by(params[:id])
				if @current_user.id == room.admin_id
					room.update!(room_params)
					# TODO: tagを追加する際に全てのタグを追加してしまうので修正する
					tags_params[:tags].each do |t|
						room_tag = RoomsTag.new(room_id: room.id, tag_id: t[:id])
						room_tag.save!
					end
					render status: 200, json: { room: room }
				else
					render status: 401, json: { error: "invalid user"  }
				end
			end
			
			def show
				room = Room.find_by(params[:id])
				render status: 200, json:room
			end

			private

			def room_params
				params.require(:room).permit(:name, :youtube_id, :is_private, :start_time, :password)
			end

			def tags_params
				params.require(:room).permit(tags: [:id,:name])
			end
		end
	end
end
