class TutorialFacade < SimpleDelegator
  attr_reader :tutorial

  def initialize(tutorial, video_id = nil)
    @tutorial = super(tutorial)
    @video_id = video_id
  end

  def current_video
    if videos == []
      videos << Video.new(title: "This tutorial has no videos at this time.", description: "Sorry, there are no videos for this tutorial at this time. We are working on it, please check back soon.", video_id: "0", thumbnail: "https://giphy.com/gifs/cjzkCDL3jZTZB6ki1B/html5", tutorial_id: self.id, position: 1)

    elsif @video_id
      videos.find(@video_id)
    else
      videos.first
    end
  end

  def next_video
    videos[current_video_index + 1] || current_video
  end

  def play_next_video?
    !(current_video.position >= maximum_video_position)
  end

  private

  def current_video_index
    videos.index(current_video)
  end

  def maximum_video_position
    videos.max_by { |video| video.position }.position
  end
end
