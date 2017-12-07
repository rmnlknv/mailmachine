class MailSetsController < ApplicationController
	before_action :load_mail_set, only: [:show, :edit, :update, :destroy]
	before_action :authenticate_user!
	
	def index
		@mail_sets = MailSet.all
	end

	def show
	end

	def new
		@mail_set = MailSet.new
	end

	def edit
	end

	def create
		@mail_set = MailSet.new(mail_set_params)
		@mail_set.user_id = current_user.id

		if @mail_set.save
			flash[:success] = 'Your mailset successfully created.'
			redirect_to @mail_set
		else
			render :new
		end
	end

	def update
		if @mail_set.update(mail_set_params)
			flash[:success] = 'Your mailset successfully updated.'
			redirect_to @mail_set
		else
			render :edit
		end
	end

	def destroy
		@mail_set.destroy
		flash[:success] = 'Your mailset successfully deleted.'
		redirect_to mail_sets_path
	end


	private

	def load_mail_set
		@mail_set = MailSet.find(params[:id])
	end

	def mail_set_params
		params.require(:mail_set).permit(:name, :addressee)
	end
end
