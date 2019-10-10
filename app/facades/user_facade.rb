class UserFacade
  def repos
    service.get_repos.map { |hash| Repo.new(hash) }.first(5)
  end

  def followers
    service.get_followers.map { |hash| GithubUser.new(hash) }
  end

  def following
    service.get_following.map { |hash| GithubUser.new(hash) }
  end

  private

  def service
    @_service ||= GithubService.new
  end
end
