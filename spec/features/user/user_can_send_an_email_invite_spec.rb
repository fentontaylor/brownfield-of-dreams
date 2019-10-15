require 'rails_helper'

describe 'As a registered user' do
  scenario "I can send an email invite to a github user with the public email" do
    VCR.turn_off!
    WebMock.allow_net_connect!
    # When I visit /dashboard
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit dashboard_path
    # And I click "Send an Invite"
    click_link "Send an Invite"
    # Then I should be on /invite
    expect(current_path).to eq('/invite')
    # And when I fill in "Github Handle" with <A VALID GITHUB HANDLE>
    valid_github_handle = 'fentontaylor'
    fill_in "GitHub Handle", with: valid_github_handle

    # And I click on "Send Invite"
    click_button "Send Invite"
    # Then I should be on /dashboard
    expect(current_path).to eq(dashboard_path)
    # And I should see a message that says "Successfully sent invite!" (if the user has an email address associated with their github account)
    expect(page).to have_content("Successfully sent invite!")
    # Or I should see a message that says "The Github user you selected doesn't have an email address associated with their account."
  end
end
