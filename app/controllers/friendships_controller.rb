class FriendshipsController < ApplicationController
  def create
    identity = Identity.find_by(user_name: params[:friend_name])
    friendship = current_user.friendships.build(friend_id: identity.user_id)

    if friendship.save
      flash[:success] = "You've added #{identity.user_name} to your friends list!"
    else
      flash[:error] = "Unable to add friend"
    end
    redirect_to dashboard_path
  end
end
