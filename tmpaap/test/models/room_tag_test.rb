require 'test_helper'

class RoomTagTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
    @room_tag = RoomsTag.new(room_id:1,tag_id:1)
  end
  test "should be valid" do
    assert @room_tag.valid?
  end
  test "room_id should be present" do
    @room_tag.room_id=""
    assert_not @room_tag.valid?

  end
  test "tag_id should be present" do
    @room_tag.tag_id=""
    assert_not @room_tag.valid?
  end 
end
