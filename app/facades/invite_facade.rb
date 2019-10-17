class InviteFacade
  attr_reader :handle

  def initialize(handle, user)
    @handle = handle
    @user = user
  end

  def send_invite
    InvitationMailer.invite(real_name, email, inviter).deliver_now
  end

  def inviter
    @user.first_name + ' ' + @user.last_name
  end

  def message
    data[:message]
  end

  def real_name
    data[:name]
  end

  def email
    data[:email]
  end

  private

  def data
    @data ||= service.get_email(@handle)
  end

  def service
    @service ||= GithubService.new(@user)
  end
end
