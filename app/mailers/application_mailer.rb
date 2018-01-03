class ApplicationMailer < ActionMailer::Base
  default from: 'no-reply@' + Rails.application.secrets.domain_name
  layout 'mailer'
end
