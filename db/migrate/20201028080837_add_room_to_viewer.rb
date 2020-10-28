class AddRoomToViewer < ActiveRecord::Migration[5.1]
  def change
    add_column :rooms, :viewer, :integer
  end
end
