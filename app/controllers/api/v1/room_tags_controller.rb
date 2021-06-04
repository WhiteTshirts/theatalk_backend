'''
  Author: Kyosuke Yokota
  Date: 20200904
'''

module Api
    module V1
        class RoomTagsController < ApplicationController
            include JwtAuthenticator
            jwt_authenticate
            before_action :set_tag, only: [:show]
            before_action :set_room_tag, only: [:destroy]
            

            def create
                room_tag = RoomsTag.new(room_tag_params)
                room_tag.save!
                render status:201, json: {  room_tag: room_tag }
            end

            

            def destroy #Roomを:idで指定、tag_idをparamとして受け付ける
                if @room_tag != nil
                    @room_tag.destroy
                    render status:204
                else
                    render status:500, json: {error: 'room&tag does not exist' }
                end
            end

            #karakawa
            #指定されたTag_idを持つroomを返す
            def show
                tag_id = @tag.id
                rooms = Room.joins(:tags).where("tag_id = #{tag_id}")
                render status:200, json: { rooms: rooms  }
            end
            
            private
                def set_tag
                    @tag = Tag.find(params[:id])
                end
                
                def room_tag_params
                    params.require(:room_tag).permit(:tag_id, :room_id)
                end
            #karakawa
                #Kyosuke Yokota
                def set_room_tag
                    room_id = params[:id]
                    tag_id  = params.require(:room_tag).permit(:tag_id)[:tag_id]
                    @room_tag = RoomsTag.find_by(tag_id: tag_id, room_id: room_id)
                end
                #Kyosuke Yokota
        end
    end
end

