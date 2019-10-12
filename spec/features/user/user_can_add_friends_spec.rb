require 'rails_helper'

describe 'A registered user' do
  before :each do
    @user = create(:user, token: ENV['GITHUB_API_KEY'])

    @github_following = GithubUser.new({login: 'hadley', html_url: 'example.com'})

    @github_follower = GithubUser.new({login: 'vermaph', html_url: 'example.com'})

    @github_follower_user = create(:user, first_name: "Nancy", token: ENV['GITHUB_API_KEY_NL'])

    info = {
      uid: '123456',
      username: 'nancylee713',
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
        within "li#follower-#{@github_follower_user_identity.username}" do
          expect(page).to have_button("Add as Friend")
        end

        within "li#follower-#{@github_follower.username}" do
          expect(page).to_not have_button("Add as Friend")
        end
      end

      within '.github-following' do
        within "li#following-#{@github_follower_user_identity.username}" do
          expect(page).to have_button("Add as Friend")
        end

        within "li#following-#{@github_following.username}" do
          expect(page).to_not have_button("Add as Friend")
        end
      end
    end
  end

  it "can click a link to add friend and see its name on dashboard" do
    within '.github-info' do
      within '.github-followers' do
        within "li#follower-#{@github_follower_user_identity.username}" do
          click_on "Add as Friend"
        end
      end
    end

    expect(page).to have_content("You've added #{@github_follower_user.first_name} to your friends list!")

    within '.github-followers' do
      within "li##{@github_follower_user_identity.username}" do
        expect(page).to_not have_button("Add as Friend")
      end
    end

    within '.friends-list' do
      expect(page).to have_content('My Friends')
      expect(page).to have_content(@github_follower_user.first_name)
      expect(page).to_not have_content(@github_following.username)
      expect(page).to_not have_content(@github_follower.username)
    end
  end
end
