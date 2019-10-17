# frozen_string_literal: true

class UserActivatorMailer < ApplicationMailer
  def activate(user)
    @user = user
    mail(to: user.email, subject: 'Please verify your email')
  end
end
