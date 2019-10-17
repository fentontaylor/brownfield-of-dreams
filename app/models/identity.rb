# frozen_string_literal: true

class Identity < ApplicationRecord
  validates_presence_of :provider, :uid, :user_id, :user_name

  belongs_to :user
end
