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
end
