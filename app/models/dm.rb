class Dm < ApplicationRecord
    has_many :dm_messages
    has_many :user_dms
    has_many :users, through: :user_dms
end
