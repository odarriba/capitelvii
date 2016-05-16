class ContactRequestMailer < ApplicationMailer
  def notify_email(contact_request)
    @contact_request = contact_request
    mail(to: Rails.application.secrets.notification_address, subject: t('.subject', name: @contact_request.name))
  end
end
