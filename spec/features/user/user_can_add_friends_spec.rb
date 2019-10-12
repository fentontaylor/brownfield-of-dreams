require 'rails_helper'

describe 'A registered user' do
  before :each do
    @user = create(:user, token: ENV['GITHUB_API_KEY'])

    @github_following = GithubUser.new({login: 'hadley', html_url: 'example.com'})

    @github_follower = GithubUser.new({login: 'vermaph', html_url: 'example.com'})

    @github_follower_user = create(:user, first_name: "Nancy", token: ENV['GITHUB_API_KEY_NL'])

    info = {
      uid: '123456',
      user_name: 'nancylee713',
      provider: 'github',
      user_id: @github_follower_user.id
    }

    @github_follower_user_identity = Identity.create!(info)

    stub_default_github_info

    visit login_path
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    click_on 'Log In'
  end

  it "can see a link to add friend if their followers or followings are also users of the app" do
    within '.github-info' do
      within '.github-followers' do
        within "#follower-#{@github_follower_user_identity.user_name}" do
          expect(page).to have_button("Add as Friend")
        end

        within "#follower-#{@github_follower.user_name}" do
          expect(page).to_not have_button("Add as Friend")
        end
      end

      within '.github-following' do
        within "#following-#{@github_follower_user_identity.user_name}" do
          expect(page).to have_button("Add as Friend")
        end

        within "#following-#{@github_following.user_name}" do
          expect(page).to_not have_button("Add as Friend")
        end
      end
    end
  end

  it "can click a link to add friend and see friend status next to its name" do
    within '.github-info' do
      within '.github-followers' do
        within "#follower-#{@github_follower_user_identity.user_name}" do
          click_on "Add as Friend"
        end
      end
    end

    expect(page).to have_content("You've added #{@github_follower_user_identity.user_name} to your friends list!")

    within '.github-followers' do
      within "#follower-#{@github_follower_user_identity.user_name}" do
        expect(page).to_not have_button("Add as Friend")
        expect(page).to have_button("Remove Friend")
      end
    end
  end
end
