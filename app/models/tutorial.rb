class Tutorial < ApplicationRecord
  has_many :videos, ->  { order(position: :ASC) }
  has_many :user_videos, through: :videos
  has_many :users, through: :user_videos


  acts_as_taggable_on :tags, :tag_list
  accepts_nested_attributes_for :videos
end
