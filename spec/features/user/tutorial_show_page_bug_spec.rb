#This test is solely for the purpose of hitting my debugger to pry into this feature.

require 'rails_helper'

describe 'As a registered user' do
  before :each do
    VCR.turn_off!

    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    Tutorial.create!(title: 'Sample Tutorial', description: 'this is a test description')
  end

  # If a tutorial doesn't have any videos and we visit its show page an error occurs when trying to call current_video.title since current_video is nil.
  it 'when i visit a toutorial show page i can confirm there is an error when trying to visit current_video.title when a tutorial has no videos' do

    visit root_path
    click_on('Sample Tutorial')
    
    save_and_open_page

    #confirmed that current_video is nill when current_video.video is called

    #added conditional to check for current_video != nil before rendering the rest of the page. If it is nil it returns a message letting user know ther are no videos for the tutorial yet.

    expect(page).to have_content("This tutorial has no videos at this time.")
  end
end
