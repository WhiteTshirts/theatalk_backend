require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup
    @user1 = User.new(name: "hiranuma", password: "1234")
    @user2 = User.new(name: "asada", password: "1234")
  end

  test "should be valid" do
    assert @user1.valid?
    assert @user2.valid?
  end

  test "can be follow" do
    # @user1.follow(@user2)
  end
end
