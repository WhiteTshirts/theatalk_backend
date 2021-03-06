class Room < ApplicationRecord
    has_many :chats 
    has_many :rooms_tags
    has_many :users
    has_many :room_histories
    has_and_belongs_to_many :tags

    validates :admin_id, presence: true
    validates :youtube_id, presence: true
    validates :name, presence: true
    
end
