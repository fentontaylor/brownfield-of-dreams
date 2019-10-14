class TutorialsController < ApplicationController
  def show
    @tutorial = Tutorial.find(params[:id])
    if video_nil_position_present?
      render_not_found
    else
      @facade = TutorialFacade.new(@tutorial, params[:video_id])
    end
  end

  private

  def video_nil_position_present?
    @tutorial.videos.any? {|v| v.position.nil?}
  end
end
