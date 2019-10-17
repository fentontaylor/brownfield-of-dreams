require 'rails_helper'

describe 'As a registered user' do
  it 'can see list of people they follow that are links' do
    user = create(:user, token: ENV['GITHUB_API_KEY'])

    stub_default_github_info

    visit login_path

    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password

    click_on 'Log In'

    within '.github-info' do
      within '.github-following' do
        expect(page).to have_css('.following-link')
      end
    end
  end
end
