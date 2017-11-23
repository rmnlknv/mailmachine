class MailsController < ApplicationController
  def new
    @mail_set = MailSet.find(params[:mail_set_id])
    @mail = @mail_set.mails.build
  end

  def create
    @mail_set = MailSet.find(params[:mail_set_id])
    @mail = @mail_set.mails.new(mail_params)
    if @mail.save
      flash[:success] = 'Your mail successfully created.'
      redirect_to mail_set_mail_path(@mail_set, @mail)
    else
      redirect_to @mail_set
    end
  end

  def update
    @mail = Mail.find(params[:id])
    @mail_set = @mail.mail_set
    if @mail.update(mail_params)
      flash[:success] = "Your mail successfully updated."
      redirect_to mail_set_mail_path(@mail.mail_set, @mail)
    else
      render :edit
    end
  end

  private

  def mail_params
    params.require(:mail).permit(:title, :body)
  end
end
