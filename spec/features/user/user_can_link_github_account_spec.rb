require 'rails_helper'

describe 'A registered user' do
  it 'can click a link to connect to GitHub and see their repos, followers, and following' do
    user = create(:user)

    visit login_path

    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password

    click_on 'Log In'

    expect(page).to have_link("Connect to Github")

    click_on "Connect to Github"
    
    expect(page).to_not have_link("Connect to Github")
    expect(page).to have_css(".github-info")
  end
end
