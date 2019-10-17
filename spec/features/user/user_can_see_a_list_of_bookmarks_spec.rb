# frozen_string_literal: true

# And they should be organized by which tutorial they are a part of
# And the videos should be ordered by their position

require 'rails_helper'

describe 'As a registered user' do
  it 'can see list of all bookmarked segments' do
    stub_default_github_info

    user = create(:user, token: ENV['GITHUB_API_KEY'])
    tutorial_1 = create(:tutorial, title: 'How to Tie Your Shoes')
    video_1 = create(:video, title: 'The Bunny Ears Technique', tutorial: tutorial_1, position: 1)
    video_2 = create(:video, title: 'Tying a Basic Knot', tutorial: tutorial_1, position: 2)

    tutorial_2 = create(:tutorial, title: 'How to code in Ruby')
    video_3 = create(:video, title: 'How to use SimpleCov', tutorial: tutorial_2, position: 2)
    video_4 = create(:video, title: 'Not bookmarked', tutorial: tutorial_2, position: 1)

    bookmarked_video_1 = create(:user_video, user: user, video: video_1)
    bookmarked_video_2 = create(:user_video, user: user, video: video_2)
    bookmarked_video_3 = create(:user_video, user: user, video: video_3)

    visit login_path

    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password

    click_on 'Log In'

    within '.bookmarked' do
      within "#bookmark-#{video_1.id}" do
        expect(page).to have_link("#{tutorial_1.title} - #{video_1.title}")
      end

      within "#bookmark-#{video_2.id}" do
        expect(page).to have_link("#{tutorial_1.title} - #{video_2.title}")
      end

      within "#bookmark-#{video_3.id}" do
        expect(page).to have_link("#{tutorial_2.title} - #{video_3.title}")
      end

      expect(page).to_not have_css("#bookmark-#{video_4.id}")
      expect(page).to_not have_content(video_4.title)
    end
  end
end
