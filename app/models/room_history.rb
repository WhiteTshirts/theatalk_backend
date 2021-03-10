class RoomHistory < ApplicationRecord
  belongs_to :user
  belongs_to :room
  validates :user_id,uniqueness:{scope: :room}
end
