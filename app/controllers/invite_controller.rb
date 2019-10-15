class InviteController < ApplicationController
  def new
  end

  def create
    handle = params["GitHub Handle"]
    service = GithubService.new(current_user)
    data = service.get_email(handle)
    email = data[:email]

    if data[:message] == 'Not Found'
      flash[:error] = "Sorry, #{handle} is not a valid GitHub handle."
    elsif email.nil?
      flash[:error] = "Sorry, #{handle} does not have a public email."
    else
      flash[:success] = "Successfully sent invite!"
    end
    
    redirect_to dashboard_path
  end

end
