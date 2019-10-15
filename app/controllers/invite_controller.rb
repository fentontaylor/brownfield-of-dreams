class InviteController < ApplicationController
  def new
  end

  def create
    handle = params["GitHub Handle"]
    service = GithubService.new(current_user)
    data = service.get_email(handle)
    email = data[:email]
    real_name = data[:name]

    if data[:message] == 'Not Found'
      flash[:error] = "Sorry, #{handle} is not a valid GitHub handle."
    elsif email.nil?
      flash[:error] = "Sorry, #{handle} does not have a public email."
    else
      inviter = current_user.first_name + ' ' + current_user.last_name
      InvitationMailer.invite(real_name, email, inviter).deliver_now
      flash[:success] = "Successfully sent invite!"
    end

    redirect_to dashboard_path
  end
end
