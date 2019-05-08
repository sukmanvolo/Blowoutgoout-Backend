class ApplicationMailer < ActionMailer::Base
  default from: 'from@example.com'
  ADMIN_EMAIL = Rails.application.secrets.admin_email
  layout 'mailer'
end
