class GithubUser
  attr_reader :user_name, :html_url

  def initialize(hash)
    @user_name = hash[:login]
    @html_url = hash[:html_url]
  end

  def friend_of?(current_user)
    friend_id = Identity.find_by(user_name: @user_name).user_id
    !!Friendship.find_by(user_id: current_user.id, friend_id: friend_id)
  end
end
