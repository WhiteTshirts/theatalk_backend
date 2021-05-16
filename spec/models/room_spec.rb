require 'rails_helper'

RSpec.describe Room, type: :model do
  before do
    @user = FactoryBot.create(:user)

  end
  it "name&youtube_id&admin_idが必要" do
    room = FactoryBot.build(:room,admin_id:@user.id)
    expect(room).to be_valid
  end
  it "nameがないと登録不可能" do
    room = FactoryBot.build(:room,admin_id:@user.id,name:nil)
    expect(room).to be_invalid
  end
  it "youtbe_idがないと登録不可能" do
    room = FactoryBot.build(:room,admin_id:@user.id,youtube_id:nil)
    expect(room).to be_invalid
  end

  it "admin_idがないと登録不可能"do
    room = FactoryBot.build(:room,admin_id:@user.id,admin_id:nil)
    expect(room).to be_invalid
  end
end
