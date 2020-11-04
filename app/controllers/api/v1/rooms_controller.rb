module Api
    module V1
        class RoomsController < ApplicationController
            include JwtAuthenticator 
            jwt_authenticate except: :index
            before_action :set_room, only: [:update, :show]

            def index
                rooms = []
                if params[:order] == "users"
                    rooms = Room.all.order(viewer: :desc).where('viewer > ?',0).select(:id, :name, :admin_id, :youtube_id, :password, :is_private,:start_time, :created_at, :updated_at,:viewer)
                else
                    rooms = Room.all.order(created_at: :desc).where('viewer > ?',0).select(:id, :name, :admin_id, :youtube_id, :password, :is_private,:start_time, :created_at, :updated_at,:viewer)
                end
                render status: 200, json: { data: { rooms: rooms } }
            end

            def create
                room_info = room_params
                room_info[:admin_id] = @current_user.id
                room_info[:viewer] = 1
                room = Room.new(room_info)
                if room.save && @current_user.update_attribute(:room_id, room.id)
                    # save したら、 RoomsTagsと紐付けを行う
                    @tag = @current_user.tags
                    tag_array = []

                    @tag.each do |t|
                        room_tag = RoomsTag.new(room_id: room.id, tag_id: t.id)
                        room_tag.save
                    end

                    render status: 201, json: { data: { room: room, user: @current_user } }
                else 
                    render status: 500, json: { data: { error: "save error" } }
                end
            end
            
            def update
                if @current_user.id == @room.admin_id
                    if @room.update(room_params)
                        render status: 200, json: { data: { room: @room } }
                    else
                        render status: 500, json: { data: { error: @room.erros } }
                    end
                else
                    render status: 401, json: { data: { error: "invalid user" } }
                end
            end
            
            def show
                render status: 200, json: { data: { room: @room } }
            end

            private
            def set_room
                @room = Room.find(params[:id])
            end

            def room_params
                params.require(:room).permit(:name, :youtube_id, :is_private, :start_time, :password)
            end
        end
    end
end
