class AddFollowesToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :follows, :integer, default: 0
    add_column :users, :followers, :integer, default: 0
  end
end
