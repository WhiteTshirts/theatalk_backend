class ChangeRoomIsPrivateDefault < ActiveRecord::Migration[5.2]
  def change
    change_column_null :rooms, :is_private, false, false
  end
end
