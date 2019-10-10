require 'rails_helper'

describe 'Following' do
  before :each do
    @following = Following.new({login: 'bobross', html_url: 'example.com'})
  end

  it 'can initialize with a hash of user_name and url' do
    expect(@following).to be_an_instance_of(Following)
  end

  it 'has attributes user_name, url' do
    expect(@following.user_name).to eq('bobross')
    expect(@following.html_url).to eq('example.com')
  end
end
