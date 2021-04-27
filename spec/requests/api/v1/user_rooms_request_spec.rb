require 'rails_helper'

RSpec.describe "UserRooms", type: :request do
  before do
    @user = FactoryBot.create(:user)
    post '/api/v1/login',params:{user:{name:@user.name,password:@user.password}}
    json = JSON.parse(response.body)
    @token = json["token"]
    @headers = {'Authorization' => "Bearer #{@token}"}
  end
  describe "GET roomusers" do
    it "ルーム入室前 401" do
      get "/api/v1/room_users",headers:@headers
      expect(response.status).to eq(401)
    end

    it "ルーム入室後" do
      #get "/api/v1/room_users",headers:@headers
      #expect(response.status).to eq(200)
    end
  end

end
