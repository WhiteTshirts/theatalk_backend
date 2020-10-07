require 'rails_helper'

RSpec.describe Chat, type: :model do
  it "room_id,user_id,textがある場合正常に登録できる" do
    chat= User.new(
      room_id:"1",
      user_id:"1",
      text:"test"
    )
    expect(chat).to be_valid
  end
  it "最大入力文字数は256,最低入力文字数は1文字" do
    chat= User.new(
      room_id:"1",
      user_id:"1",
      text:""
    )
    expect(chat).to be_valid

  end
  it "user_idとroom_idが必須" do
  end

end
