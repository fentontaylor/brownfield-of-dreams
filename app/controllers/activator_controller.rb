class ActivatorController < ApplicationController
  def update
    @user = User.find_by_id(params[:id])
    if params[:activation_token] == @user.activation_token
      @user.update(is_active: true)
    else
      render file: 'public/404', status: 404
    end
  end
end
