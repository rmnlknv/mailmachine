require 'rails_helper'

RSpec.describe MailSetsController, type: :controller do
	let(:mail_set) { create :mail_set, user_id: @user.id }

	describe "GET #index" do
		sign_in_user

		let(:mail_sets) { create_list(:mail_set, 3, user_id: @user.id) }

		before { get :index }

		it 'populates an array of all mail sets' do
			expect(assigns(:mail_sets)).to match_array(mail_sets)
		end

		it 'renders index view' do
			expect(response).to render_template :index
		end
	end

	describe "GET #show" do
		sign_in_user

		before { get :show, params: {id: mail_set} }

		it 'assigns the requested mail set to @mail_set' do
			expect(assigns(:mail_set)).to eq mail_set
		end

		it 'renders show view' do
			expect(response).to render_template :show
		end
	end

	describe "GET #new" do
		sign_in_user

		before { get :new }

		it 'assigns a new MailSet to @mail_set' do
			expect(assigns(:mail_set)).to be_a_new(MailSet)
		end

		it 'renders new view' do
			expect(response).to render_template :new
		end
	end

	describe "GET #edit" do
		sign_in_user

		before { get :edit, params: {id: mail_set} }

		it 'assigns the requested mail set to @mail_set' do
			expect(assigns(:mail_set)).to eq mail_set
		end

		it 'renders edit view' do
			expect(response).to render_template :edit
		end
	end

	describe "POST #create" do
		sign_in_user

		context 'with valid attributes' do 
			it 'saves the new mail set to the database' do
				expect{ post :create, params: { mail_set: attributes_for(:mail_set) } }.to change(MailSet, :count).by(1)
			end

			it 'redirects to show view' do
				post :create, params: { mail_set: attributes_for(:mail_set) }
				expect(response).to redirect_to mail_set_path(assigns(:mail_set))
			end
		end

		context 'with invalid attributes' do
			it 'does not save thr mail set to the database' do
				expect{ post :create, params: { mail_set: attributes_for(:invalid_mail_set) } }.to_not change(MailSet, :count)
			end

			it 're-renders new view' do
				post :create, params: { mail_set: attributes_for(:invalid_mail_set) }
				expect(response).to render_template :new
			end
		end
	end

	describe "PATCH #update" do
		sign_in_user

		context 'with valid attributes' do
			it 'assigns the requested mail_set to @mail_set' do
				patch :update, params: { id: mail_set, mail_set: attributes_for(:mail_set) }
				expect(assigns(:mail_set)).to eq mail_set
			end

			it 'changes mail_set attributes' do 
				patch :update, params: { id: mail_set, mail_set: { name: "Just fine name", addressee: "test1@mail.com"} }
				mail_set.reload
				expect(mail_set.name).to eq "Just fine name"
				expect(mail_set.addressee).to eq "test1@mail.com"
			end

			it 'redirects to the updated mail_set' do
				patch :update, params: { id: mail_set, mail_set: attributes_for(:mail_set) }
				expect(response).to redirect_to mail_set
			end
		end

		context 'with invalid attributes' do
			before { patch :update, params: { id: mail_set, mail_set: { name: "no", addressee: "123@" } } }
			it 'does not change attributes of mail_set' do
				mail_set.reload
				expect(mail_set.name).to eq 'MyString'
				expect(mail_set.addressee).to eq ""
			end

			it 're-renders edit view' do
				expect(response).to render_template :edit
			end
		end
	end

	describe 'DELETE #destroy' do
		sign_in_user
		
		before { mail_set }

		it 'deletes mail set from the database' do
			expect { delete :destroy, params: {id: mail_set} }.to change(MailSet, :count).by(-1)
		end

		it 'redirect to index view' do
			delete :destroy, params: {id: mail_set}
			expect(response).to redirect_to mail_sets_path
		end
	end

end
