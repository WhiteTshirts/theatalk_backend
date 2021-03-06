class CreateUserDms < ActiveRecord::Migration[5.1]
  def change
    create_table :user_dms do |t|
      t.integer :user_id
      t.integer :dm_id

      t.timestamps
    end
  end
end
