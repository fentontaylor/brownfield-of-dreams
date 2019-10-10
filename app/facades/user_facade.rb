class UserFacade
  def repos
    GithubService.new.get_repos.map do |hash|
      Repo.new(hash)
    end.first(5)
  end

  def followers
    GithubService.new.get_followers.map do |hash|
      Follower.new(hash)
    end
  end

  def following
    GithubService.new.get_following.map do |hash|
      Following.new(hash)
    end
  end
end
