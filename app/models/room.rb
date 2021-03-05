class Room < ApplicationRecord
    has_many :chats #rikuiwasaki
    has_many :rooms_tags
    has_many :users, through: :room_users
    has_many :room_users
    #Kyosuke Yokota
    has_and_belongs_to_many :tags
    validates :admin_id, presence: true
    validates :youtube_id, presence: true
    validates :name, presence: true
    #Kyosuke Yokota
end
