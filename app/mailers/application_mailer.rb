class ApplicationMailer < ActionMailer::Base
  default from: 'InterRoute.io <' + Rails.application.secrets.email_provider_username + '>'
  layout 'mailer'
end
