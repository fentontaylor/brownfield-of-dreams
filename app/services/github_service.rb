class GithubService
  def initialize(user)
    @user = user
  end

  def get_email(handle)
    get_json("users/#{handle}")
  end

  def get_repos
    get_json('user/repos')
  end

  def get_followers
    get_json('user/followers')
  end

  def get_following
    get_json('user/following')
  end

  private

  def conn
    token = @user.token? ? @user.token : ENV['GITHUB_API_KEY']
    Faraday.new('https://api.github.com/',
                headers: { 'Authorization' => "bearer #{token}" })
  end

  def get_json(path)
    response = conn.get do |req|
      req.url path
      req.params['affiliation'] = 'owner'
    end
    JSON.parse(response.body, symbolize_names: true)
  end
end
