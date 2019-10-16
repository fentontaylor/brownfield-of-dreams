class UserFacade
  def initialize(user)
    @user = user
  end

  def has_friends?
    !@user.friends.empty?
  end

  def has_bookmarks?
    !@user.bookmarked_videos.empty?
  end

  def repos
    service.get_repos.map { |hash| Repo.new(hash) }.shuffle.first(5)
  end

  def followers
    service.get_followers.map { |hash| GithubUser.new(hash) }
  end

  def following
    service.get_following.map { |hash| GithubUser.new(hash) }
  end

  private

  def service
    @_service ||= GithubService.new(@user)
  end
end
