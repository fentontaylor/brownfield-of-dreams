require 'rails_helper'

describe 'GithubUser' do
  before :each do
    @user = GithubUser.new({login: 'bobross', html_url: 'example.com'})
  end

  it 'can initialize with a hash of user_name and url' do
    expect(@user).to be_an_instance_of(GithubUser)
  end

  it 'has attributes user_name, url' do
    expect(@user.user_name).to eq('bobross')
    expect(@user.html_url).to eq('example.com')
  end

  describe 'instance methods' do
    it "#is_friend_of?" do
      # create 3 users
      current_user = create(:user, id: 1)
      user_1 = create(:user, id: 2)
      user_2 = create(:user, id: 3)
      ghuser_1 = GithubUser.new(login: 'ghuser-1', html_url: '123@github.com')
      ghuser_2 = GithubUser.new(login: 'ghuser-2', html_url: '123@github.com')
      identity_1 = Identity.create(provider: 'github', uid: '1234', user: user_1, user_name: 'ghuser-1')
      identity_2 = Identity.create(provider: 'github', uid: '1234', user: user_2, user_name: 'ghuser-2')

      # create friendship
      friendship = Friendship.create(user_id: current_user.id, friend_id: user_1.id)

      expect(ghuser_1.is_friend_of?(current_user)).to be true
      expect(ghuser_2.is_friend_of?(current_user)).to be false
    end
  end
end
