class Friendship < ApplicationRecord
  validates_presence_of :user_id, :friend_id

  belongs_to :user
  belongs_to :friend, class_name: 'User'
end
