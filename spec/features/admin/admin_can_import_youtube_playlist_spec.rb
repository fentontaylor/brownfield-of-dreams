require 'rails_helper'

describe "An Admin can import youtube playlist" do
  before :each do
    admin = create(:user, role: 1)
    allow_any_instance_of(ApplicationController)
      .to receive(:current_user)
      .and_return(admin)
  end

  it "When I visit new tutorial creation page", :js do
    visit new_admin_tutorial_path

    title = 'New Tutorial Title'
    description = 'This is a description'
    thumbnail = 'thumbnail.jpg'

    fill_in 'Title', with: title
    fill_in 'Description', with: description
    fill_in 'Thumbnail', with: thumbnail

    click_on 'Import YouTube Playlist'

    # capybara cannot find remote form params, but functionality works in development
    fill_in "tutorial[playlist_id]", with: "PL1Y67f0xPzdOq2FcpWnawJeyJ3ELUdBkJ"

    click_on "Save"

    tutorial = Tutorial.last

    expect(current_path).to eq admin_dashboard_path

    expect(page).to have_content('Successfully created tutorial. View it here.')

    expect(page).to have_link('View it here')

    click_on 'View it here'

    expect(current_path).to eq tutorial_path(tutorial)

    expect(page).to have_content(tutorial.videos.first.title)
    expect(page).to have_content(tutorial.videos.second.title)
  end
end
