require 'rails_helper'

describe "RelationShipAPI" do
    before do
        @user = FactoryBot.create(:user)
        @users = FactoryBot.create_list(:user_create,5)

        post '/api/v1/login',params:{user:{name:@user.name,password:@user.password}}
        json = JSON.parse(response.body)
        @token = json["token"]
        @headers = {'Authorization' => "Bearer #{@token}"}
    end
    it 'フォローする' do
        for user_ in @users do
            follow_param={
                user:{
                    id:user_.id
                }
            }
        end
    end

end
