class DmMessage < ApplicationRecord
    belongs_to :dm
    belongs_to :user
end
