# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'turing_tutorials@example.com'
  layout 'mailer'
end
