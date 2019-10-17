class Friendship < ApplicationRecord
  validates :friend_id, :presence => true, :uniqueness => true
  validates_presence_of :user_id, :friend_id

  belongs_to :user
  belongs_to :friend, class_name: 'User'
end
