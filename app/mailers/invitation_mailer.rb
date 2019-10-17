class InvitationMailer < ApplicationMailer
  def invite(real_name, email, inviter)
    @real_name = real_name
    @inviter = inviter
    mail(to: email, subject: 'Invitation to Turing Tutorials!')
  end
end
