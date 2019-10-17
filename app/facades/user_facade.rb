class UserFacade < SimpleDelegator
  def initialize(user)
    @user = super(user)
  end

  def friends?
    !friends.empty?
  end

  def bookmarks?
    !bookmarked_videos.empty?
  end

  def five_repos
    repos.first(5)
  end

  def repos
    service.fetch_repos.map { |hash| Repo.new(hash) }
  end

  def followers
    service.fetch_followers.map { |hash| GithubUser.new(hash) }
  end

  def following
    service.fetch_following.map { |hash| GithubUser.new(hash) }
  end

  private

  def service
    @service ||= GithubService.new(@user)
  end
end
