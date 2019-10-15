class UsersController < ApplicationController
  # skip_before_action :verify_authenticity_token, only: [:update]

  def show
    @user = UserFacade.new(current_user)
  end

  def new
    @user = User.new
  end

  def create
    user = User.create(user_params)
    if user.save
      session[:user_id] = user.id
      flash[:success] = "Logged in as #{user.first_name}"
      redirect_to dashboard_path
    else
      flash[:error] = 'Username already exists'
      render :new
    end
  end

  def update
    token = request.env["omniauth.auth"]["credentials"]["token"]
    user = User.find(current_user.id)
    user.token = token
    user.save
    redirect_to dashboard_path
  end

  private

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password)
  end

end
