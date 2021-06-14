module Api
	module V1
		class ChatsController < ApplicationController
			jwt_authenticate

			def index
				if @current_user.room_id == nil
					render status: 401
					return
				end

				if chats = Chat.where(room_id: @current_user.room_id).order(updated_at: :desc)
					render status: 200, json: chats, root: "chats", adapter: :json
				else
					render status: 404, json: { error: "can't get Info"}
				end
			end

			def create
				chat_info = chat_params
				chat_info[:user_id] = @current_user.id
				chat_info[:room_id] = @current_user.room_id                
				@new_chat = Chat.new(chat_info)
				@new_chat.save!
				RoomChannel.broadcast_to("room_#{chat_info[:room_id]}", chat_info)
				render status: 201, json: { chat: chat_info  }

			end

			def update
				chat = Chat.find(params[:id])
				if chat.user_id != @current_user.id
					render status: 401, json: {error: "invalid user"}
				else
					updated_chat = Chat.update(chat_params)
					render status: 200, json: { chat: updated_chat  }
				end
			end

		end
		
	end
end
