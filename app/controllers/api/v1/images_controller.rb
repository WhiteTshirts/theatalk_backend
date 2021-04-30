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
        image = images[params[:id].to_i]
        image_path = image[:path]
        image_data = File.open(image_path).read
        image_base64 = Base64.encode64(image_data)
        render status: 200, json: image_base64
      end

    end
  end
end
