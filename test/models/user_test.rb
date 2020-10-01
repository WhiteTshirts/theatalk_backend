require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup
    @user1 = User.new(name: "name1", password: "password1")
  end

  test "should be valid" do
    assert @user1.valid?
  end
end
