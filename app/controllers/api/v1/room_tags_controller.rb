module Api
	module V1
		class RoomTagsController < ApplicationController
			jwt_authenticate
			before_action :set_room_tag, only: [:destroy]

			def create
				room_tag = RoomsTag.new(room_tag_params)
				room_tag.save!
				render status:201, json: {  room_tag: room_tag }
			end

			def destroy
				room_tag = RoomsTag.find_by(tag_id: room_tag_params[:tag_id], room_id: params[:id])
				room_tag.destroy!
				render status: 204
			end

			def show
				tag = Tag.find(params[:id])
				rooms = Room.joins(:tags).where("tag_id = #{tag.id}")
				render status:200, json: { rooms: rooms  }
			end
            
			private

			def room_tag_params
				params.require(:room_tag).permit(:tag_id, :room_id)
			end

		end
	end
end

