require 'rails_helper'

describe 'visitor sees a video show' do
  it 'vistor clicks on a tutorial title from the home page' do
    tutorial = create(:tutorial)
    video = create(:video, tutorial_id: tutorial.id)

    visit '/'

    click_on tutorial.title

    expect(current_path).to eq(tutorial_path(tutorial))
    expect(page).to have_content(video.title)
    expect(page).to have_content(tutorial.title)
  end

  it 'sees an error message  if there\'s a video associated with the tutorial that doesn\'t have a position set' do
    tutorial = create(:tutorial)
    video_1 = create(:video, tutorial_id: tutorial.id, position: nil)
    video_2 = create(:video, tutorial_id: tutorial.id)

    visit '/'

    click_on tutorial.title
    expect(page).to have_content("The page you were looking for doesn't exist.")
  end
end
