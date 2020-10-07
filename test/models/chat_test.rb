require 'test_helper'

class ChatTest < ActiveSupport::TestCase
  def setup
    @chat_test= chats(:one)
  end
  test "should be valid" do
    assert @chat_test.valid?
    assert_equal("test",@chat_test.text)
  end
  test "text should not be too long" do
    @chat_test.text = "a"*256
    assert_not @chat_test.valid?
  end
  test "text should be  long" do
    @chat_test.text = "aafdsf"
    assert @chat_test.valid?
    
  end
  test "text should be present" do
    @chat_test.text=""
    assert_not @chat_test.valid?
  end


end
