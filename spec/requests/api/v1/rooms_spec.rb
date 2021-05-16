#rikuiwasaki

require 'rails_helper'

describe 'RoomAPI' do
  before do
    @user = FactoryBot.create(:user)
    post '/api/v1/login',params:{user:{name:@user.name,password:@user.password}}
    json = JSON.parse(response.body)
    @token = json["token"]
    @headers = {'Authorization' => "Bearer #{@token}"}
    @room
  end
  it '全てのRoomを取得' do
    FactoryBot.create_list(:room_create,10)
    get '/api/v1/rooms',headers:@headers
    rooms=JSON.parse(response.body)
    expect(response.status).to eq(200)
    expect(rooms['rooms'].length).to eq(10)
    puts(rooms['rooms'])
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
    it 'ルームに入る' do
      room = FactoryBot.create(:room)
      room_params={
        user:{
          room_id:room.id
        }
      }
      post '/api/v1/room_users',headers:@headers,params:room_params
      expect(response.status).to eq(201)
    end
  end

  # it 'ルームを編集' do
  #   FactoryBot.create(:room_create)
  #   time=Time.current
  #   edit_params={name:'edited_room',
  #               youtube_id:'2',
  #               is_private:false,
  #               start_time:time
  #   }
  #   expect{put '/api/v1/rooms',headers:@headers,params:edit_params}.to change(Room,:count).by(+1)

  #   edited_room=JSON.parse(response.body)
  #   puts(edited_room)
  #   expect(response.status).to eq(200)
  #   expect(edited_room.room.youtube_id).to eq(2)
  #   expect(edited_room.room.name).to eq('edited_room')
  #   expect(edited_room.room.start_time).to eq(time)
  # end

end

#rikuiwasaki