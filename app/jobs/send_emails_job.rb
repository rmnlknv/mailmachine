class SendEmailsJob < ApplicationJob
  queue_as :default

  def perform(email)
  	@email = email
  	MainMailer.send_emails(@email.id).deliver_later
  end
end
