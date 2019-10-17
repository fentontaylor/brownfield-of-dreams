# frozen_string_literal: true

class Video < ApplicationRecord
  has_many :user_videos, dependent: :destroy
  has_many :users, through: :user_videos
  belongs_to :tutorial

  validates_presence_of :position
  validates_numericality_of :position, only_integer: true
end
