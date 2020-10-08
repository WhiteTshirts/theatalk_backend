require 'test_helper'

class TagsUserTest < ActiveSupport::TestCase
  def setup
    @tag_user = TagsUser.new(tag_id:1, user_id:1)
  end
  test "should be valid" do
    assert @tag_user.valid?
  end
end
