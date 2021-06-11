module Api
  module V1
    class UserRoomTagsController < ApplicationController
      jwt_authenticate
      before_action :set_tag, only: [:show]

      def show
        @room = Room.where(id: @room_ids)
        render status:200, json: { room: @room  }
      end

      private

      def set_tag 
        @tag = @current_user.tags
        tag_array = []
        # TODO: mapでrefactoring
        @tag.each do |t|
            tag_array.push(t.id)                    
        end

        @room_tag = RoomsTag.where(tag_id: tag_array)
        @room_ids = []
        # TODO: mapでrefactoring
        @room_tag.each do |t|
          @room_ids.push(t.room_id)
        end
      end
    end
  end
end

