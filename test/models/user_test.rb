require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup
    @user1 = User.new(name: "hiranuma", password: "1234")
    @user2 = User.new(name: "asada", password: "1234")
    print @user
    # @user1.follow(@user2)
    # @user = User.find_by(name: "hiranuma")
  end

  test "should be valid" do
    assert @user1.valid?
    assert @user2.valid?
    # assert @user.valid?
  end

  # test "can be follow?" do
  #   assert @user1.following?(@user2)
  # end
end
