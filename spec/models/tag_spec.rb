require 'rails_helper'

RSpec.describe Tag, type: :model do
  it 'nameがある時に正常に登録できる' do
    # test内容
    tag = Tag.new(
      name:"tag1"
    )
    expect(tag).to be_valid
  end

  # pending "add some examples to (or delete) #{__FILE__}"
end
