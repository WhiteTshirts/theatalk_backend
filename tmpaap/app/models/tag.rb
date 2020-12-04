'''
  Author: Kyosuke Yokota
  Date: 20200904
'''

class Tag < ApplicationRecord
    has_and_belongs_to_many :users
    has_and_belongs_to_many :rooms
    has_many :rooms_tags
    validates :name, presence: true, uniqueness: true 
end
