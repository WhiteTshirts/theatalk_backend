module Api
    module V1
        class UsersController < ApplicationController
          jwt_authenticate except: [:create, :show, :index]
          before_action :set_user, only: [:show, :update]
          
          # ユーザ一覧を取得
          def index 
              @users = User.where(room_id: params[:room_id]).order(updated_at: :desc)
              render status: 200, json: {users: @users}#@users, root:"users",adapter: :json
          end

          def show
            @user = User.select(:id,:name,:profile,:room_id,:created_at,:updated_at).find(params[:id])
            render status: 200, json: @user, root:"user",adapter: :json
          end
          # ユーザ登録
          def create
              @user = User.new(user_params)
              if @user.save
                jwt_token = encode(@user.id)
                response.headers['X-Authentication-Token'] = jwt_token
                render status:201, json: { user: @user, token: jwt_token  }
              else
                render status:409, json:{user:@user.errors}
              end
          end

          def update
              if @current_user.update_attributes(user_params)
                  render status:200, json: { user: @user  }
                else
                  render status:500, json: { error: @user.errors }
              end
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

