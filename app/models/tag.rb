class Tag < ApplicationRecord
    has_and_belongs_to_many :users
    has_and_belongs_to_many :rooms
    has_many :rooms_tags
    has_many :tags_users
    validates :name, presence: true, uniqueness: true 
end
