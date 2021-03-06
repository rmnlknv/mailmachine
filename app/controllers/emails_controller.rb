class EmailsController < ApplicationController
  before_action :load_email, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :check_permission, except: [:new, :create, :send_emails, :send_later]
  
  def new
    @mail_set = MailSet.find(params[:mail_set_id])
    @email = @mail_set.emails.build
    @email.attachments.build
  end

  def edit
    @mail_set = @email.mail_set
  end

  def create
    @mail_set = MailSet.find(params[:mail_set_id])
    @email = @mail_set.emails.new(email_params)
    @email.user_id = current_user.id
    if @email.save
      flash[:success] = 'Your mail successfully created.'
      redirect_to mail_set_email_path(@mail_set, @email)
    else
      redirect_to @mail_set
    end
  end

  def update
    @mail_set = @email.mail_set
    if @email.update(email_params)
      flash[:success] = "Your mail successfully updated."
      redirect_to mail_set_email_path(@email.mail_set, @email)
    else
      render :edit
    end
  end

  def show
    @mail_set = @email.mail_set
  end

  def destroy
    @mail_set = @email.mail_set
    @email.destroy
    flash[:success] = "Your mail successfully deleted."
    redirect_to mail_set_path(@mail_set)
  end

  def send_emails
    @email = Email.find(params[:email_id])
    SendEmailsJob.set(wait: 5.seconds).perform_later(@email)
    flash[:success] = "Your mail queued to send."
    @history = History.new(email_id: @email.id, email_title: @email.title, recipients_amount: @email.mail_set.addressee.split.count, queued: DateTime.now, sent: false, user_id: current_user.id)
    @history.save
    redirect_to histories_path
  end

  def send_later
    @email = Email.find(params[:email_id])
    datetime = DateTime.civil(params[:date][:year].to_i, params[:date][:month].to_i, params[:date][:day].to_i,
                              params[:date][:hour].to_i, params[:date][:minute].to_i)
    SendEmailsJob.delay(run_at: datetime).perform_later(@email)
    flash[:success] = "Your mail queued to send at specified date and time."
    @history = History.new(email_id: @email.id, email_title: @email.title, recipients_amount: @email.mail_set.addressee.split.count, queued: DateTime.now, sent: false, user_id: current_user.id)
    @history.save
    redirect_to histories_path
  end

  private

  def email_params
    params.require(:email).permit(:title, :body, attachments_attributes: [:file])
  end

  def load_email
    @email = Email.find(params[:id])
  end

  def check_permission
    if current_user.id != Email.find(params[:id]).user_id
      flash[:danger] = "You have no access."
      redirect_to root_path
    end
  end
end
