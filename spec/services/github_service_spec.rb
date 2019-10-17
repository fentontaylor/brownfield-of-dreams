require 'rails_helper'

describe 'GithubService' do
  before :each do
    VCR.turn_off!
    nancy = User.create!(email: 'nancy@example.com', first_name: 'Nancy', last_name: 'Lee', password: 'password', role: :default, token: ENV['GITHUB_API_KEY_NL'])

    stub_github_info('nancys')

    @service = GithubService.new(nancy)
  end

  it 'returns parsed repo data' do
    github_repos = @service.fetch_repos

    expect(github_repos).to be_an Array

    expect(github_repos.first).to have_key(:name)
    expect(github_repos.first).to have_key(:html_url)
  end

  it 'returns parsed follower data' do
    github_followers = @service.fetch_followers

    expect(github_followers).to be_an Array

    expect(github_followers.first).to have_key(:login)
    expect(github_followers.first).to have_key(:html_url)
  end

  it 'returns parsed following data' do
    github_following = @service.fetch_following

    expect(github_following).to be_an Array

    expect(github_following.first).to have_key(:login)
    expect(github_following.first).to have_key(:html_url)
  end
end

describe 'Email invite' do
  it 'returns public email' do
    VCR.turn_off!
    WebMock.allow_net_connect!

    user = create(:user)
    service = GithubService.new(user)

    valid_handle = 'fentontaylor'
    data_1 = service.get_email(valid_handle)

    expect(data_1[:email]).to eq('fentontaylor@gmail.com')

    valid_handle_no_email = 'nancylee713'
    data_2 = service.get_email(valid_handle_no_email)

    expect(data_2[:email]).to eq(nil)

    invalid_handle = 'asdfkljd;'
    no_data = service.get_email(invalid_handle)

    result = {
      message: 'Not Found',
      documentation_url: 'https://developer.github.com/v3/users/#get-a-single-user'
    }

    expect(no_data).to eq(result)
  end
end
