class ApplicationController < ActionController::Base
  helper_method :app_user?
  helper_method :current_user
  helper_method :find_bookmark
  helper_method :list_tags
  helper_method :tutorial_name
  helper_method :restricted_tutorial?
  helper_method :active_user?

  add_flash_types :success

  def app_user?(user)
    !Identity.find_by(user_name: user.user_name).nil?
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def active_user?
    current_user.is_active
  end

  def find_bookmark(id)
    current_user.user_videos.find_by(video_id: id)
  end

  def tutorial_name(id)
    Tutorial.find(id).title
  end

  def restricted_tutorial?(tutorial)
    !tutorial.classroom || (current_user&.is_active)
  end

  def four_oh_four
    render file: 'public/404', status: 404
  end

  def add_videos(tutorial)
    response = Faraday.get("https://www.googleapis.com/youtube/v3/playlistItems?key=#{ENV['YOUTUBE_API_KEY']}&playlistId=#{tutorial.playlist_id}&part=snippet&maxResults=50&order=date")
    data = JSON.parse(response.body, symbolize_names: true)
    data[:items].each.with_index(1) do |vid, index|
      tutorial.videos.create!(
        title:       vid[:snippet][:title],
        description: vid[:snippet][:description],
        thumbnail:   vid[:snippet][:thumbnails][:high][:url],
        video_id:    vid[:snippet][:resourceId][:videoId],
        position:    index
      )
    end
  end
end
