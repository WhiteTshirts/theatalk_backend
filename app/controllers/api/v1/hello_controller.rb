module Api
  module V1
    class HelloController < ApplicationController

      def index
        render json: 200
      end

      def show
        render json: 200
      end

    end
  end
end