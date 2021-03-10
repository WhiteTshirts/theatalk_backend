module Api
    module V1
        class RoomsController < ApplicationController
            include JwtAuthenticator 
            jwt_authenticate 
            before_action :set_room, only: [:update]

            def index
                rooms = Room.all.order(created_at: :desc).where('viewer > ?',-1).select(:id, :name, :admin_id, :youtube_id, :password, :is_private,:start_time, :created_at, :updated_at,:viewer)
                render status:200, json: rooms
            end

            def create
                room_info = room_params
                room_info[:admin_id] = @current_user.id
                room_info[:viewer] = 0
                room = Room.new(room_info)
                if room.save && @current_user.update_attribute(:room_id, room.id)
                    # save したら、 RoomsTagsと紐付けを行う
                    @tag = @current_user.tags
                    tag_array = []

                    @tag.each do |t|
                        room_tag = RoomsTag.new(room_id: room.id, tag_id: t.id)
                        room_tag.save
                    end

                    render status:201, json: { room: room }
                else 
                    render status:500, json: { error: "save error" }
                end
            end
            
            def update
                if @current_user.id == @room.admin_id
                    if @room.update(room_params)
                        render status:200, json: room
                    else
                        render status:500, json: { error: @room.erros  }
                    end
                else
                    render status:401, json: { error: "invalid user"  }
                end
            end
            
            def show
                if room = Room.find_by(params[:id])
                    render status:200, json: room
                else
                    render status:404
                end
            end

            private
            def set_room
                @room = Room.find_by(params[:id])
            end

            def room_params
                params.require(:room).permit(:name, :youtube_id, :is_private, :start_time, :password)
            end
        end
    end
end
