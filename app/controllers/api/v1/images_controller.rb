module Api
  module V1
    class ImagesController < ApplicationController
      jwt_authenticate only: [:update]
      require 'base64'

      @@images = [
        { 'id': 0, 'path': "public/images/avaters/pose_pien_uruuru_man.png" }
      ]

      def index
        render status: 200, json: @@images
      end

      def show
        image_path = @@images[params[:id].to_i][:path]
        image_base64 = convert_base64(image_path)
        render status: 200, json: image_base64
      end

      def update
        avater = Avater.find_by(user_id: @current_user.id)
        if avater.present?
          avater.path = @@images[params[:id].to_i][:path]
        else
          avater = Avater.new(user_id: @current_user.id, path: @@images[params[:id].to_i][:path])
        end

        if avater.save
          render status: 200, json: avater
        else
          render status: 500, json: { error: "update error" }
        end
      end

      private

      def convert_base64(path)
        Base64.encode64(File.open(path).read)
      end

    end
  end
end
