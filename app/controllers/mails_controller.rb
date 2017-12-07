class MailsController < ApplicationController
  before_action :authenticate_user!
  
  def new
    @mail_set = MailSet.find(params[:mail_set_id])
    @mail = @mail_set.mails.build
    @mail.attachments.build
  end

  def edit
    @mail = Mail.find(params[:id])
    @mail_set = @mail.mail_set
  end

  def create
    @mail_set = MailSet.find(params[:mail_set_id])
    @mail = @mail_set.mails.new(mail_params)
    @mail.user_id = current_user.id
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

  def show
    @mail = Mail.find(params[:id])
    @mail_set = @mail.mail_set
  end

  def destroy
    @mail = Mail.find(params[:id])
    @mail_set = @mail.mail_set
    @mail.destroy
    flash[:success] = "Your mail successfully deleted."
    redirect_to mail_set_path(@mail_set)
  end

  private

  def mail_params
    params.require(:mail).permit(:title, :body, attachments_attributes: [:file])
  end
end
