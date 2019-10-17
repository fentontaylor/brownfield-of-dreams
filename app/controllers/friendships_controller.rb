# frozen_string_literal: true

class FriendshipsController < ApplicationController
  def create
    identity = Identity.find_by(user_name: params[:friend_name])
    friendship = current_user.friendships.build(friend_id: identity.user_id)

    if friendship.save
      flash[:success] = "You've added #{identity.user_name} to your friends list!"
    else
      flash[:error] = 'Unable to add friend'
    end
    redirect_to dashboard_path
  end

  def destroy
    friendship = Friendship.find_by(friendship_params)
    user = User.find(params[:friend_id])
    if friendship.delete
      flash[:success] = "You removed #{user.first_name} #{user.last_name} from your friends list."
    else
      flash[:error] = 'Unable to remove friend at this time.'
    end
    redirect_to dashboard_path
  end

  private

  def friendship_params
    params.permit(:friend_id, :user_id)
  end
end
