module Api
  module V1
    class UsersController < ApplicationController
      jwt_authenticate except: [:create]
      @@images = [
        { 'id': 0, 'path': "public/images/avaters/dog.jpeg" },
        { 'id': 1, 'path': "public/images/avaters/cat.jpeg" },
        { 'id': 2, 'path': "public/images/avaters/whale.jpeg" },
        { 'id': 3, 'path': "public/images/avaters/sheep.jpeg" },
        { 'id': 4, 'path': "public/images/avaters/penguin.jpeg" },
        { 'id': 5, 'path': "public/images/avaters/dragon.jpeg" }
      ]
      def index 
        users = User.all
        render status: 200, json: users, user: @current_user, scope: :detail
      end

      def show
        user = User.find_by(id: params[:id])
        render status: 200, json: user, user: @current_user, scope: :all
      end

      def create
        @user = User.new(user_params)
        @user.save!
        jwt_token = encode(@user.id)
        response.headers['X-Authentication-Token'] = jwt_token
        render status: 201, json: { user: @user, token: jwt_token  }

      end
      def avater
        avater = Avater.find_by(user_id:params[:id])
        avater_id = avater.present?? avater.id : 0
        image_path = @@images[avater_id][:path]
        render status: 201, json: { avater: { id: avater_id, image: convert_base64(image_path) } }
      end

      def update
        @current_user.update_attributes!(user_params)
        render status: 200, json: { user: @user  }
      end

      private

      def user_params
        params.require(:user).permit(:name, :profile, :room_id, :password)
      end
      def convert_base64(path)
        Base64.encode64(File.open(path).read)
      end
    end
  end
end

