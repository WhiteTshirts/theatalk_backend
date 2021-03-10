class RoomChannel < ApplicationCable::Channel
  def subscribed
     stream_for "room_#{current_user.room_id}"
     # RoomChannel.broadcast_to("room_#{current_user.room_id}","hello#{current_user.room_id}")

  end

  def unsubscribed
    room_id = current_user.room_id
    if current_user.update_attribute(:room_id, nil)
      unless room_id.nil?
        room = Room.find_by(id: room_id)
        room.increment!(:viewer, -1)
        #info = { type: "del",user:{id: current_user.id, name: current_user.name}}
        #RoomChannel.broadcast_to("room_#{current_user.room_id}", info)
      end
    else
    end
    # Any cleanup needed when channel is unsubscribed
  end

  def chat(data)
    # RoomChannel.broadcast_to('message','hello')
  end

end
