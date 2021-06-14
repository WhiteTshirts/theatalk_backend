require 'rails_helper'
describe 'UserAPI' do
  before do
    @user = FactoryBot.create(:user)
    sign_in(@user)
  end

  it '全てのTagを取得' do
    get '/api/v1/tags#index',headers:@headers
    users=JSON.parse(response.body)
    expect(response.status).to eq(200)
  end

  it '新しいTagを作成' do
    valid_params={
                  tag:{
                    name:'tag1'
                  }
                }
    expect{post '/api/v1/tags',headers:@headers,params:valid_params}.to change(Tag,:count).by(+1)
    expect(response.status).to eq(201)
  end
end