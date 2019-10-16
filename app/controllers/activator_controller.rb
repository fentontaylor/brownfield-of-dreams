class ActivatorController < ApplicationController
  def update
    @user = User.find_by_id(params[:id])
    @user.update(is_active: true)
  end
end
