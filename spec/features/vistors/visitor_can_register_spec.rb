# frozen_string_literal: true

require 'rails_helper'

describe 'visitor can create an account' do
  it 'visits the home page' do
    VCR.turn_off!

    email = 'jimbob@aol.com'
    first_name = 'Jim'
    last_name = 'Bob'
    password = 'password'
    password_confirmation = 'password'

    visit '/'

    click_on 'Sign In'

    expect(current_path).to eq(login_path)

    click_on 'Sign up now.'

    expect(current_path).to eq(new_user_path)

    fill_in 'Email', with: email
    fill_in 'First name', with: first_name
    fill_in 'Last name', with: last_name
    fill_in 'Password', with: password
    fill_in 'Password confirmation', with: password

    click_on'Create Account'

    expect(current_path).to eq(dashboard_path)

    expect(page).to have_content(email)
    expect(page).to have_content(first_name)
    expect(page).to have_content(last_name)
    expect(page).to_not have_content('Sign In')
  end
end
