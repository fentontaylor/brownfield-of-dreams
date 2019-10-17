require 'rails_helper'

describe 'As a registered user' do
  scenario 'I can send an email invite to a github user with the public email' do
    VCR.turn_off!
    WebMock.allow_net_connect!

    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit dashboard_path

    click_link 'Send an Invite'

    expect(current_path).to eq('/invite')

    valid_github_handle = 'fentontaylor'

    fill_in 'GitHub Handle', with: valid_github_handle

    click_button 'Send Invite'

    expect(current_path).to eq(dashboard_path)

    expect(page).to have_content('Successfully sent invite!')
  end
end
