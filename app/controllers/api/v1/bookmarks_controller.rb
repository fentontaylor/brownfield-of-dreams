class Api::V1::BookmarksController < ApplicationController
  
  def create
    UserVideo.new(user_video_params).save
  end

  private

  def user_video_params
    params.permit(:user_id, :video_id)
  end
end
