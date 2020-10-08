require 'test_helper'

class ChatTest < ActiveSupport::TestCase
  def setup
    @chat_test= Chat.new(room_id: 1,user_id: 1,text: "test")
  end
  test "should be valid" do
    assert @chat_test.valid?
  end
  test "text should not be too long" do
    @chat_test.text = "a"*256
    assert_not @chat_test.valid?
  end
  test "text should be  long" do
    @chat_test.text = "a"*50
    assert @chat_test.valid?
    
  end
  test "text should be present" do
    @chat_test.text=""
    assert_not @chat_test.valid?
  end


end
