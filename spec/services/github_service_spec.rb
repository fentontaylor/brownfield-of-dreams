require 'rails_helper'

describe "GithubService" do
  it "returns parsed repo data" do
    VCR.turn_off!
    nancy = User.create!(email: 'nancy@example.com', first_name: 'Nancy', last_name: 'Lee', password:  "password", role: :default, token: ENV['GITHUB_API_KEY_NL'])
    
    nancys_repos = File.open('./fixtures/nancys_repos.json')
    stub_request(:get, 'https://api.github.com/user/repos?affiliation=owner')
      .to_return(status: 200, body: nancys_repos)

    service = GithubService.new(nancy)

    github_repos = service.get_repos

    expect(github_repos).to be_an Array

    expect(github_repos.first).to have_key(:name)
    expect(github_repos.first).to have_key(:html_url)
  end
end
