require 'rails_helper'

describe 'A registered user' do
  before :each do
    @user = create(:user, token: ENV['GITHUB_API_KEY'])
    @nancy = create(:user, first_name: 'Nancy', token: ENV['GITHUB_API_KEY_NL'])

    @hadley = GithubUser.new(login: 'hadley', html_url: 'example.com')
    @vermaph = GithubUser.new(login: 'vermaph', html_url: 'example.com')

    info = {
      uid: '123456',
      user_name: 'nancylee713',
      provider: 'github',
      user: @nancy
    }

    @nancy_github = Identity.create!(info)

    stub_default_github_info

    visit login_path
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    click_on 'Log In'
  end

  it 'can see a link to add friend if their followers or followings are also users of the app' do
    within '.friends-list' do
      expect(page).to have_content("You haven't added any friends yet.")
    end

    within '.github-info' do
      within '.github-followers' do
        within "#follower-#{@nancy_github.user_name}" do
          expect(page).to have_button('Add as Friend')
        end

        within "#follower-#{@vermaph.user_name}" do
          expect(page).to_not have_button('Add as Friend')
        end
      end

      within '.github-following' do
        within "#following-#{@nancy_github.user_name}" do
          expect(page).to have_button('Add as Friend')
        end

        within "#following-#{@hadley.user_name}" do
          expect(page).to_not have_button('Add as Friend')
        end
      end
    end
  end

  it 'can click a link to add friend and see friend status next to its name' do
    within '.github-info' do
      within '.github-followers' do
        within "#follower-#{@nancy_github.user_name}" do
          click_on 'Add as Friend'
        end
      end
    end

    expect(page).to have_content("You've added #{@nancy_github.user_name} to your friends list!")

    within '.friends-list' do
      user = @nancy
      github_user_name = @nancy_github.user_name
      within "#friend-#{user.id}" do
        expect(page).to have_content("#{user.first_name} #{user.last_name} (#{github_user_name})")
        expect(page).to have_button('Remove Friend')
      end
    end

    within '.github-followers' do
      within "#follower-#{@nancy_github.user_name}" do
        expect(page).to_not have_button('Add as Friend')
      end
    end
  end

  it 'can click a link to remove a friend' do
    user = @nancy
    github_user_name = @nancy_github.user_name

    within '.github-followers' do
      within "#follower-#{github_user_name}" do
        click_button('Add as Friend')
      end
    end

    within '.friends-list' do
      within "#friend-#{user.id}" do
        expect(page).to have_button('Remove Friend')
        click_button('Remove Friend')
      end
    end

    within '.friends-list' do
      expect(page).to_not have_css("#friend-#{user.id}")
      expect(page).to have_content("You haven't added any friends yet.")
    end

    expect(page).to have_content("You removed #{user.first_name} #{user.last_name} from your friends list.")

    within '.github-followers' do
      within "#follower-#{github_user_name}" do
        expect(page).to have_button('Add as Friend')
      end
    end
  end
end
