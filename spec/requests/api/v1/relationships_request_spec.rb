require 'rails_helper'

describe "RelationShipAPI" do
    before do
        @user = FactoryBot.create(:user)
        @users = FactoryBot.create_list(:user_create,5)
        sign_in(@user)
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
