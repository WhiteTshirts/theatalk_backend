class User < ApplicationRecord
	has_secure_password
	has_many :chats
	has_many :relationships
	has_many :followings, through: :relationships, source: :follow
	has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'follow_id'
	has_many :followers, through: :reverse_of_relationships, source: :user
	has_and_belongs_to_many :tags
	has_many :dm_messages
	has_many :user_dms
	has_many :dms, through: :user_dms
	has_many :room_histories
	has_many :rooms, through: :room_histories
	validates :password, presence: true, on: :create
	validates :name, presence: true, uniqueness: true

	def follow(other_user)
		unless self == other_user
			self.relationships.find_or_create_by(follow_id: other_user.id)
		end
	end

	def unfollow(other_user)
		relationship = self.relationships.find_by(follow_id: other_user.id)
		if relationship
			relationship.destroy
		end
	end

	def following?(other_user)
		self.followings.include?(other_user)
	end

end
