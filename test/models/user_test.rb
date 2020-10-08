require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user1 = User.new(name: "hiranuma", password: "1234")
    @user2 = User.new(name: "asada", password: "1234")
    @user3 = User.new(name: "yamada", password: "1234")
    @user4 = users(:one)
  end

  test "the same name" do
    assert_not @user3.valid?
  end

  test "should be valid" do
    assert @user1.valid?
    assert @user2.valid?
  end

  test "dont follow" do
    assert_not @user1.following?(@user2)
  end
end
