# frozen_string_literal: true

# Applicationmailer
class ApplicationMailer < ActionMailer::Base
  default from: 'example@gmail.com'
  layout 'mailer'
end
