#rikuiwasaki

require 'rails_helper'
describe 'UserAPI' do
  before do
    @user = FactoryBot.create(:user)
    post '/api/v1/login',params:{user:{name:@user.name,password:@user.password}}
    json = JSON.parse(response.body)
    @token = json["token"]
    @headers = {'Authorization' => "Bearer #{@token}"}
  end
  it '全てのUserを取得' do
    get '/api/v1/users#index',headers:@headers
    users=JSON.parse(response.body)
    expect(response.status).to eq(200)
  end
  it '新しいUserを作成' do
    valid_params={
                  user:{
                    name:'user_1',
                    password:'password',
                    room_id:'1'
                  }
                }
    expect{post '/api/v1/users',headers:@headers,params:valid_params}.to change(User,:count).by(+1)
    expect(response.status).to eq(201)
  end
  it '他のユーザ情報閲覧' do
    created_user=FactoryBot.create(:user_create)
    get "/api/v1/users/#{@user.id}",headers:@headers
    user=JSON.parse(response.body)["user"]
    expect(response.status).to eq(200)
    expect(user["name"]).to eq(@user.name)
    expect(user["room_id"]).to eq(@user.room_id)
    expect(user["follow_number"]).to eq(@user.follow_number)
  end

  
end
#rikuiwasaki