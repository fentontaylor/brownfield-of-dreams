class UserFacade
  def initialize(user)
    @user = user
  end

  # Using active record
  # def bookmarked_tutorials
  #   @user.user_videos.joins(video: :tutorial)
  #     .select("tutorials.id")
  #     .map {|obj| Tutorial.find(obj.id)}
  #     .uniq
  # end

  def bookmarked_tutorials
    Tutorial.joins(:users)
      .where("users.id = #{@user.id}")
      .select(
        "tutorials.id as id,
        tutorials.title as title,
        videos.id as video_id,
        videos.title as video_title"
      )
    # @user.user_videos
    #   .joins(:tutorial)
    #   .select(
    #     'videos.title AS video_title,
    #     tutorials.title AS tutorial_title,
    #     videos.id AS video_id,
    #     tutorials.id AS tutorial_id'
    #   )
    # @user.user_videos.map { |uv| Tutorial.find(Video.find(uv.video_id).tutorial_id) }.uniq
  end

  def bookmarked_videos(tutorial_id)
    @user.user_videos.map { |uv| Video.find(uv.video_id) }.select { |v| v.tutorial_id == tutorial_id }
  end

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
    @_service ||= GithubService.new(@user)
  end
end
