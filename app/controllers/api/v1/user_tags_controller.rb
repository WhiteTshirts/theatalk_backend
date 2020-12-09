'''
  author: Kyosuke Yokota
  Date: 20200907
'''

module Api
    module V1
        class UserTagsController < ApplicationController
            include JwtAuthenticator
            jwt_authenticate

            #karakawa
            before_action :set_user , only: [:show]
            
            #ユーザーのタグの解除
            def destroy
              tag_id = params[:id]
              destroy_tag_user = TagsUser.find_by("user_id = #{@current_user.id} and tag_id = #{tag_id}")
              if destroy_tag_user != nil
                destroy_tag_user.destroy
                render status:204, json: { message: 'Delete tag_user', tag_user: destroy_tag_user }
              else
                render status:500, json: {message: "Not found users' tag"}
              end
            end
            #karakara

            def create
                tag_user_info = tag_user_params
                tag_user_info[:user_id] = @current_user.id
                tag_user = TagsUser.new(tag_user_info)
                if tag_user.save
                    render status:201, json: { tag_user: tag_user }
                else
                    render status:500, json: { error: tag_user.errors }
                end
            end
            
            #karakawa
            #userの持つtagを表示
            def show
              @tags = @user.tags
              render status:200, json: { tags: @tags }
            end
            
            private
            def set_user
              @user = User.find(params[:id])
            end
            
            #Kyosuke Yokota 
            def tag_user_params
                params.require(:tag_user).permit(:tag_id)
            end
            #KyosukeYokota

        end
    end
end
