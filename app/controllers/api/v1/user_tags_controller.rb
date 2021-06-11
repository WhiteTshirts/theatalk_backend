module Api
  module V1
    class UserTagsController < ApplicationController
      jwt_authenticate

      def destroy
        tag_id = params[:id]
        destroy_tag_user = TagsUser.find_by("user_id = #{@current_user.id} and tag_id = #{tag_id}")
        destroy_tag_user.destroy!
        render status: 204, json: { message: 'Delete tag_user', tag_user: destroy_tag_user }
      end

      def create
        tag_user_info = tag_user_params
        tag_user_info[:user_id] = @current_user.id
        tag_user = TagsUser.new(tag_user_info)
        tag_user.save!
        render status: 201, json: { tag_user: tag_user }
      end
      
      def show
        user = User.find(params[:id])
        render status: 200, json: { tags: user.tags }
      end

      def get_num
        tag_id = tag_params[:id]
        users_num = TagsUser.where(tag_id: tag_id).count
        render status: 200, json: { users_num: users_num　}
      end

      private

      def tag_params
        params.require(:tag).permit(:id)
      end 
      
      def tag_user_params
        params.require(:tag_user).permit(:tag_id)
      end

    end
  end
end
