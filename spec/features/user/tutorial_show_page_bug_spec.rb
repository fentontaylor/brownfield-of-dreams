require 'rails_helper'

describe 'As a registered user' do
  before :each do
    VCR.turn_off!

    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    Tutorial.create!(title: 'Sample Tutorial', description: 'this is a test description')
  end

  it 'when i visit a tutorial that has no videos I am directed to a default page notifying me that there are no videos for the given tutorial' do

    visit root_path
    click_on('Sample Tutorial')

    expect(page).to have_content("This tutorial has no videos at this time.")
  end
end
