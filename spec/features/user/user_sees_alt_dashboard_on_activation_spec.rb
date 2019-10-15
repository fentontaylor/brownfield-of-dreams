require 'rails_helper'

describe 'As newly signed up user' do
  context 'When I visit my dashboard' do
    it 'Shows a message that I must activate my account to see full features' do
      visit '/'

      click_link 'Register'

      email = 'bobross@example.com'
      first_name = 'Bob'
      last_name = 'Ross'
      password = 'happy'

      fill_in 'Email', with: email
      fill_in 'First name', with: first_name
      fill_in 'Last name', with: last_name
      fill_in 'Password', with: password
      fill_in 'Password confirmation', with: password

      click_on 'Create Account'

      expect(current_path).to eq(dashboard_path)

      expect(page).to have_content("Logged in as #{first_name}")
      expect(page).to have_content("This account has not yet been activated. Please check your email.")
      expect(page).to have_content("Status: Inactive")

      expect(page).to_not have_link('Connect to GitHub')
    end

    it 'As an active user, I see all features' do
      user = create(:user)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit dashboard_path

      expect(page).to have_content("Status: Active")
      expect(page).to have_link('Connect to GitHub')
    end
  end
end
