class RoomsTag < ApplicationRecord
  belongs_to :room
  belongs_to :tag
  validates :room_id, presence: true, uniqueness: { scope: :tag_id }
  validates :tag_id, presence: true
end
