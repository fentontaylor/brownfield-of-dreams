class User < ApplicationRecord
  has_many :user_videos
  has_many :videos, through: :user_videos
  has_many :tutorials, through: :videos

  has_many :friendships
  has_many :friends, through: :friendships
  has_many :identities

  validates :email, uniqueness: true, presence: true
  validates_presence_of :password_digest
  validates_presence_of :first_name
  enum role: [:default, :admin]
  has_secure_password

  def gh_user_name
    identities.where(provider: "github").first.user_name
  end

  def bookmarked_videos
    videos.includes(:tutorial).order("videos.tutorial_id, videos.position")
  end
end
