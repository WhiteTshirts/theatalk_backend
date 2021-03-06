class CreateDmMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :dm_messages do |t|
      t.integer :user_id
      t.integer :dm_id
      t.string :message

      t.timestamps
    end
  end
end
