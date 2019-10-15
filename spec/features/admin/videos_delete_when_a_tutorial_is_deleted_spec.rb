require 'rails_helper'

describe "As an admin" do
  before :each do
    admin = create(:admin)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    @tutorial_1 = create(:tutorial)
    video_1 = create(:video, tutorial: @tutorial_1)
    video_2 = create(:video, tutorial: @tutorial_1)

    tutorial_2 = create(:tutorial)
    video_3 = create(:video, tutorial: tutorial_2)
  end

  scenario "when I delete a tutorial all associated videos are deleted as well." do
    visit admin_dashboard_path

    within(first(".admin-tutorial-card")) do
      expect(page).to have_content(@tutorial_1.title)
      click_on "Destroy"
    end

    expect(page).to have_content("You have successfully deleted Tutorial: #{@tutorial_1.title}!")

    expect(current_path).to eq(admin_dashboard_path)

    within('.admin-tutorial-card') do
      expect(page).to_not have_content(@tutorial_1.title)
    end
  end
end
