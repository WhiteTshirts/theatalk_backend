class TagsUser < ApplicationRecord
    validates :user_id, presence: true
    validates :tag_id, presence: true  #follow 外す外さない問題ありのためコメントアウト, uniqueness: {scope: :user_id}  #karakawa
end
