class MainMailer < ApplicationMailer
  default from: ENV['gmail_username']
  
  def send_mails(email_id)
  	@email = Email.find(email_id)
  	@email.attachments.each do |attachment|
      attachments[attachment.file.file.filename] = File.read(attachment.file.file.path)
  	end
    mail(
      # bcc for hiding reciever's emails from each other
      bcc: @email.mail_set.addressee.split.uniq,
      subject: @email.title
    )
  end
end
