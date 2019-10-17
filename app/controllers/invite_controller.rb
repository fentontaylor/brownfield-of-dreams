# frozen_string_literal: true

class InviteController < ApplicationController
  def new; end

  def create
    facade = InviteFacade.new(params['GitHub Handle'], current_user)

    if facade.message == 'Not Found'
      flash[:error] = "Sorry, #{facade.handle} is not a valid GitHub handle."
    elsif facade.email.nil?
      flash[:error] = "Sorry, #{facade.handle} does not have a public email."
    else
      facade.send_invite
      flash[:success] = 'Successfully sent invite!'
    end

    redirect_to dashboard_path
  end
end
