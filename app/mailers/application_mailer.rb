class ApplicationMailer < ActionMailer::Base
  default from: Rails.application.secrets.smtp['address']
  layout 'mailer'
end
