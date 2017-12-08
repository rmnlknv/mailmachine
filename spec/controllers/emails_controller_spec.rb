require 'rails_helper'

RSpec.describe EmailsController, type: :controller do
  let(:mail_set) { create :mail_set, user_id: @user.id}

  describe 'GET #new' do
    sign_in_user

    before { get :new, params: { mail_set_id: mail_set.id} }

    it 'assigns a new Email to @email' do
      expect(assigns(:email)).to be_a_new(Email)
    end

    it 'builds new attachment for email' do
      expect(assigns(:email).attachments.first).to be_a_new(Attachment)
    end

    it 'renders new email view' do
      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do
    sign_in_user
    context 'with valid attributes' do
      it 'saves the new mail to the database' do
        expect { post :create, params: { email: attributes_for(:email), mail_set_id: mail_set } }.to change(mail_set.emails, :count).by(1)
      end

      it 'redirect to created mail' do
        post :create, params: { email: attributes_for(:email), mail_set_id: mail_set }
        expect(response).to redirect_to mail_set_email_path(assigns(:mail_set), assigns(:email))
      end
    end

    context 'with invalid attributes' do
      it 'does not save mail to the database' do
        expect { post :create, params: { email: attributes_for(:invalid_email), mail_set_id: mail_set } }.to_not change(Email, :count)
      end

      it 'redirects to mail set show view' do
        post :create, params: { email: attributes_for(:invalid_email), mail_set_id: mail_set }
        expect(response).to redirect_to mail_set_path(assigns(:mail_set))
      end
    end
  end

  describe 'PATH #update' do
    sign_in_user
    let(:email) { create(:email, mail_set: mail_set, user_id: @user.id) }

    context 'with valid attributes' do
      it 'assigns the requested mail to @mail' do
        patch :update, params: { id: email, mail_set_id: mail_set, email: attributes_for(:email) }
        expect(assigns(:email)).to eq email
      end

      it 'assigns the mail set' do
        patch :update, params: { id: email, mail_set_id: mail_set, email: attributes_for(:email) }
        expect(assigns(:mail_set)).to eq mail_set
      end

      it 'changes mail attributes' do
        patch :update, params: { id: email, mail_set_id: mail_set, email: { title: 'new title', body: 'new body'} }
        email.reload
        expect(email.title).to eq 'new title'
        expect(email.body).to eq 'new body'
      end

      it 'redirect to updated mail' do
        patch :update, params: { id: email, mail_set_id: mail_set, email: { title: 'new title', body: 'new body'} }
        expect(response).to redirect_to mail_set_email_path(assigns(:mail_set), assigns(:email))
      end
    end

    context 'with invalid attributes' do
      it 'does not changes mail attributes with emptry title and body' do
        patch :update, params: { id: email, mail_set_id: mail_set, email: { title: nil, body: nil } }
        email.reload
        expect(email.title).not_to eq nil
        expect(email.body).not_to eq nil
      end

      it 'does not changes mail attributes with too long title and body' do
        patch :update, params: { id: email, mail_set_id: mail_set, email: { title: "unfortunately, this title is too long for one mail", body: "Body is ok" } }
        email.reload
        expect(email.title).not_to eq "unfortunately, this title is too long for one mail"
        expect(email.body).not_to eq "Body is ok"
      end

      it 'renders edit view' do
        patch :update, params: { id: email, mail_set_id: mail_set, email: { title: nil, body: nil } }
        expect(response).to render_template :edit
      end
    end
  end
end
