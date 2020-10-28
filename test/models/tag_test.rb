require 'test_helper'

class TagTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
    @tag = Tag.new(name:"tag1")
  end
  test "should be valid" do
    assert @tag.valid?
  end
end
