require 'test_helper'

class RoomTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
    @room=Room.new(name:"test",admin_id:1,youtube_id:"aaaa")
  end
  test "should be valid" do
    assert @room.valid?
  end
  test "room id should be present" do
    @room.name = ""
    assert_not @room.valid?
  end
  test "youtube_id id should be present" do
    @room.youtube_id = ""
    assert_not @room.valid?
  end  
  test "admin_id  should be present" do
    @room.admin_id = ""
    assert_not @room.valid?
  end

end
