require 'rails_helper'

describe 'RoomAPI' do
  before do
    @user = FactoryBot.create(:user)
    sign_in(@user)
  end

  it '全てのRoomを取得' do
    FactoryBot.create_list(:room_create,10)
    get '/api/v1/rooms',headers:@headers
    rooms=JSON.parse(response.body)
    expect(response.status).to eq(200)
    expect(rooms['rooms'].length).to eq(10)
  end

  context 'ルームを作成し、入室' do

    it '新しいROOMを作成' do
      valid_params={
        room:{
          name:'room1',
          youtube_id:'1',
          is_private:false,
          start_time:Time.current
          }
        }
      expect{post '/api/v1/rooms',headers:@headers,params:valid_params}.to change(Room,:count).by(+1)
      expect(response.status).to eq(201)
    end

    it '非公開の新しいROOMを作成' do
      valid_params={
        room:{
          name:'room1',
          youtube_id:'1',
          is_private:true,
          password:"password",
          start_time:Time.current
          }
        }
      expect{post '/api/v1/rooms',headers:@headers,params:valid_params}.to change(Room,:count).by(+1)
      expect(response.status).to eq(201)
    end

    it 'ルームに入ったあと、ルーム内にいることを確認' do
      room = FactoryBot.create(:room)
      room_params={
        user:{
          room_id: room.id
        }
      }
      post '/api/v1/room_users',headers:@headers,params:room_params
      expect(response.status).to eq(201)
      get '/api/v1/room_users',headers:@headers
      json = JSON.parse(response.body)
      expect(response.status).to eq(200)
    end
  end

  context '返り値判定' do
    it 'タグが正しいか' do
      FactoryBot.create_list(:tag_create, 2)
      params = {
        room: {
          name: "room_name",
          youtube_id: "1", 
          is_private: true,
          start_time: "2015-11-12 00:00:00+0100",
          tags: [{
                  id: 1,
                  name: "tag1"
                },
                {
                  id: 2,
                  name: "tag2"
                }]
        }
      }
      post "/api/v1/rooms", headers: @headers, params: params
      json = JSON.parse(response.body)
      get "/api/v1/rooms/#{json["room"]["id"]}", headers: @headers
      json = JSON.parse(response.body)
      expect(json["rooms"][0]["tags"].length).to eq(2)
    end
  end

end