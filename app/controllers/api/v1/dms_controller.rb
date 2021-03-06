module Api
  module V1
    class DmsController < ApplicationController
      include JwtAuthenticator 
      jwt_authenticate
      def index
        
        dms = @current_user.dms
        render status:200, json: {dms: dms}
      end
      def create
        for user in dm_users_id do
          if User.find_by(id: user)
          else
            render status:400, json:{ error:"no user" }
          end
        end
        dm = @current_user.dms.create
        for user in dm_users_id do
          dm.users.build(id: user)
        end
        dm.save
        render status:201, json:{ dm:{users: dm.users} }

      end
      def update
      end
      
      def dm_users_id
        params.require(:users_id)
      end
    end
  end
end

