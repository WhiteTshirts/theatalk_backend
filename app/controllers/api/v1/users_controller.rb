module Api
    module V1
        class UsersController < ApplicationController
          jwt_authenticate except: [:create, :show, :index]
          before_action :set_user, only: [:show, :update]
          
          # ユーザ一覧を取得
          def index 
              users = User.where(room_id: params[:room_id]).order(updated_at: :desc).select(:id,:name,:profile,:room_id,:created_at,:updated_at)
              render status: 200, json: { status: 'SUCCESS', message: 'Loaded posts', data: { users: users } }
          end

          def show
            user = User.find(params[:id]).select(:id,:name,:profile,:room_id,:created_at,:updated_at)
            render status: 200, json: { status: 'SUCCESS', message: 'Loaded posts', data: { user: @user } }
          end
          # ユーザ登録
          def create
              @user = User.new(user_params, follows: 0, followers: 0)
              if @user.save
                jwt_token = encode(@user.id)
                response.headers['X-Authentication-Token'] = jwt_token
                render status:201, json: { status: 'SUCCESS', data: { user: @user }, token: jwt_token }
              else
                render status:409, json:{status:'ERROR',error: @user.errors}
              end
          end

          def update
              if @current_user.update_attributes(user_params)
                  render status:200, json: { status: 'SUCCESS', message: 'Updated the post', data: { user: @user } }
                else
                  render status:500, json: { status: 'ERROR', message: 'Not updated', data: { error: @user.errors } }
              end
          end

          def get_follow_numbers
            @user = User.find_by(id: params[:id])
            render status: 200, json: { data: { user: { user_id: @user.id, follows: @user.follows, followers: @user.followers } } }
          end

          def user_params
              params.require(:user).permit(:name, :profile, :room_id, :password)
          end

          def set_user
              @user = User.find(params[:id])
          end
        end
    end
end

