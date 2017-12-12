class SendEmailsJob < ApplicationJob
  queue_as :default

  def perform(email)
  	@email = email
  	MainMailer.send_emails(@email.id).deliver_later
  	@history = History.where(email_id: @email.id).last
    @history.update_attributes(sent: true)
  end
end
