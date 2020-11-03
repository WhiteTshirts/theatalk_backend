class AddFollowesToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :follow_number, :integer, default: 0
    add_column :users, :follower_number, :integer, default: 0
  end
end
