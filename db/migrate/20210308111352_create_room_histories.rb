class CreateRoomHistories < ActiveRecord::Migration[5.1]
  def change
    create_table :room_histories,id: false,primary_key:[:user,:room] do |t|
      t.references :user, foreign_key: true
      t.references :room, foreign_key: true

      t.timestamps
    end
  end
end
