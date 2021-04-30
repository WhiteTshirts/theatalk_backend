module Api
  module V1
    class ImagesController < ApplicationController
      require 'base64'

      def index
        images = [ { 'id': 0, 'path': "public/images/avaters/pose_pien_uruuru_man.png" } ]
        render status: 200, json: images
      end

      def show
        images = [
          { 'id': 0, 'path': "public/images/avaters/pose_pien_uruuru_man.png" }
        ]
        image_path = images[params[:id].to_i][:path]
        image_base64 = convert_base64(image_path)
        render status: 200, json: image_base64
      end

      private

      def convert_base64(path)
        Base64.encode64(File.open(path).read)
      end

    end
  end
end
