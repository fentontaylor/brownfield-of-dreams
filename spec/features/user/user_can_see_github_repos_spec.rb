require 'rails_helper'

describe 'As a registered user' do
  it 'can see list of 5 repos that are links' do
    user = create(:user, token: ENV["GITHUB_API_KEY"])

    visit login_path

    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password

    click_on 'Log In'

    within '.github-info' do
      expect(page).to have_content('GitHub')
      within '.github-repos' do
        expect(page).to have_css('.repo-link', count: 5)
      end
    end
  end

  it 'can see list of 5 repos that are links' do
    nancy = User.create!(email: 'nancy@example.com', first_name: 'Nancy', last_name: 'Lee', password:  "password", role: :default, token: ENV['GITHUB_API_KEY_NL'])
    nathan = User.create!(email: 'nathan@example.com', first_name: 'Nathan', last_name: 'Thomas', password:  "password", role: :default, token: ENV['GITHUB_API_KEY_NT'])

    # This fixture file was created with a real call to the endpoint with
    # the actual API key represented by ENV['GITHUB_API_KEY_NL']
    nancys_repos = File.open('./fixtures/nancys_repos.json')
    stub_request(:get, 'https://api.github.com/user/repos')
      .to_return(status: 200, body: nancys_repos)

    visit login_path

    fill_in 'Email', with: nancy.email
    fill_in 'Password', with: nancy.password

    click_on 'Log In'

    within '.github-info' do
      expect(page).to have_content('GitHub')
      within '.github-repos' do
        expect(page).to have_link('.dotfiles')
        expect(page).to have_link("1906-house-salad")
        expect(page).to have_link("activerecord-obstacle-course")
        expect(page).to have_link("Alberts_tutorial")
        expect(page).to have_link("apollo_14")
      end
    end

    click_on 'Log Out'

    # This fixture file was created with a real call to the endpoint with
    # the actual API key represented by ENV['GITHUB_API_KEY_NT']
    nathans_repos = File.open('./fixtures/nathans_repos.json')
    stub_request(:get, 'https://api.github.com/user/repos')
      .to_return(status: 200, body: nathans_repos)

    visit login_path

    fill_in 'Email', with: nathan.email
    fill_in 'Password', with: nathan.password

    click_on 'Log In'

    within '.github-info' do
      expect(page).to have_content('GitHub')
      within '.github-repos' do
        expect(page).to have_link("1904_m2_mid_mod")
        expect(page).to have_link("activerecord-obstacle-course")
        expect(page).to have_link("api_practice")
        expect(page).to have_link("apollo_14")
        expect(page).to have_link("backend-curriculum-site")
      end
    end
  end
end
