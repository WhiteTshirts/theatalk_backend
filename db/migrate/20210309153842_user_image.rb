class UserImage < ActiveRecord::Migration[5.1]
  def change

    add_column :users, :img_path, :string
  end
end
