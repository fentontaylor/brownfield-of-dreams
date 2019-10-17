require 'rails_helper'

describe 'As an unregistered user' do
  before :each do
    @tutorial_1 = create(:tutorial)
    create(:video, tutorial: @tutorial_1)
  end

  it 'when I try to bookmark a video I see a notice informing me that I must be signed in to bookmark.' do
    visit tutorial_path(@tutorial_1)
    click_button('Bookmark')

    expect(current_path).to eq(tutorial_path(@tutorial_1))
  end

  it 'as a registered user I am able to bookmark a video' do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit tutorial_path(@tutorial_1)
    click_button('Bookmark')

    expect(page).to have_content('Bookmark added to your dashboard!')
  end
end
