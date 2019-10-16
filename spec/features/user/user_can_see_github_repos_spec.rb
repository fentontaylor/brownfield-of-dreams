require 'rails_helper'

describe 'As a registered user' do
  it 'can see list of 5 repos that are links' do
    VCR.turn_off!

    stub_github_info("nancys")

    nancy = User.create(email: 'nancy@example.com', first_name: 'Nancy', last_name: 'Lee', password:  "password", role: :default, token: ENV['GITHUB_API_KEY_NL'], is_active: true)
    nathan = User.create(email: 'nathan@example.com', first_name: 'Nathan', last_name: 'Thomas', password:  "password", role: :default, token: ENV['GITHUB_API_KEY_NT'], is_active: true)

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

    stub_github_info("nathans")

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
