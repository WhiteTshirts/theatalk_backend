require 'rails_helper'

RSpec.describe User, type: :model do
  it "name&password が必要" do
    user = FactoryBot.build(:user)
    expect(user).to be_valid
  end

  it "重複した名前は登録不可能" do
    user = FactoryBot.create(:user)
    user2 = FactoryBot.build(:user)
    expect(user2).to be_invalid
  end

  it "登録には名前が必要" do
    user = FactoryBot.build(:user,name:nil)
    expect(user).to be_invalid
  end
  
  it "登録にはパスワードが必要" do
    user = FactoryBot.build(:user,password:nil)
    expect(user).to be_invalid
  end
end
