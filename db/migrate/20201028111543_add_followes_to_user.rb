class AddFollowesToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :follows, :integer
    add_column :users, :followers, :integer
  end
end
