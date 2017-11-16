class MailSetsController < ApplicationController
	def index
		@mail_sets = MailSet.all
	end

	def show
		@mail_set = MailSet.find(params[:id])
	end

	def new
		@mail_set = MailSet.new
	end

	def edit
		@mail_set = MailSet.find(params[:id])
	end

	def create
		@mail_set = MailSet.new(mail_set_params)

		if @mail_set.save
			redirect_to @mail_set
		else
			render :new
		end
	end

	def update
		@mail_set = MailSet.find(params[:id])

		if @mail_set.update(mail_set_params)
			redirect_to @mail_set
		else
			render :edit
		end
	end

	def destroy
		@mail_set = MailSet.find(params[:id])
		@mail_set.destroy
		redirect_to mail_sets_path
	end


	private

	def mail_set_params
		params.require(:mail_set).permit(:name, :addressee)
	end
end
