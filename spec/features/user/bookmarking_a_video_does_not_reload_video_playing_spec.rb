require 'rails_helper'

describe 'As a registered user' do
  before :each do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    @tutorial = create(:tutorial)
    create(:video, tutorial: @tutorial)
  end

  it 'when i visit a tutorial and click_on the bookmark button the page does not reload and the video is added to my bookmarks' do
    visit(tutorial_path(@tutorial.id))
    click_button('Bookmark')
    # when capybara clicks button it errors out with 'No route matches [POST] "/"', however the function works on localhost.
    expect(current_path).to eq(tutorial_path(@tutorial.id))
    # need to figure out how to test for page not reloading.
    visit dashboard_path
    within :bookmarked do
      expect(page).to have_content(@tutorial.title)
    end
  end
end
