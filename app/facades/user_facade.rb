# frozen_string_literal: true

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
    service.get_repos.map { |hash| Repo.new(hash) }
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
