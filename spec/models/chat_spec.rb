require 'rails_helper'

RSpec.describe Chat, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @room = FactoryBot.create(:room, admin_id: @user.id)
  end

  it "room_id,user_id,textがある場合正常に登録できる" do
    chat= Chat.new(
      room_id: @room.id,
      user_id: @user.id,
      text: "test"
    )
    expect(chat).to be_valid
  end

  it "最大入力文字数は256,最低入力文字数は1文字" do
    chat= FactoryBot.build(
      :chat,user_id: @user.id,
      room_id: @room.id,
      text: "",
    )
    expect(chat).to be_invalid
  end

  it "user_idとroom_idが必須" do
    chat= FactoryBot.build(
      :chat,
      user_id: @user.id,
      room_id: nil,
    )
    expect(chat).to be_invalid

    chat= FactoryBot.build(
      :chat,
      user_id: nil,
      room_id: @room.id,
    )
    expect(chat).to be_invalid
  end
end
