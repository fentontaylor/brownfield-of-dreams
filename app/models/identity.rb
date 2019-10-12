class Identity < ApplicationRecord
  validates_presence_of :provider, :uid, :user_id, :username

  belongs_to :user
end
