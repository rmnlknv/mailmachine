require 'rails_helper'

RSpec.describe MailsController, type: :controller do
  let(:mail_set) { create :mail_set }

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'saves the new mail to the database' do
        expect { post :create, params: { mail: attributes_for(:mail), mail_set_id: mail_set} }.to change(mail_set.mails, :count).by(1)
      end

      it 'redirect to created mail' do
        post :create, params: { mail: attributes_for(:mail), mail_set_id: mail_set }
        expect(response).to redirect_to mail_set_mail_path(assigns(:mail_set), assigns(:mail))
      end
    end

    context 'with invalid attributes' do
      it 'does not save mail to the database' do
        expect { post :create, params: { mail: attributes_for(:invalid_mail), mail_set_id: mail_set } }.to_not change(Mail, :count)
      end

      it 'redirects to mail set show view' do
        post :create, params: { mail: attributes_for(:invalid_mail), mail_set_id: mail_set }
        expect(response).to redirect_to mail_set_path(assigns(:mail_set))
      end
    end
  end

  describe 'PATH #update' do
    let(:mail) { create(:mail, mail_set: mail_set) }

    context 'with valid attributes' do
      it 'assigns the requested mail to @mail' do
        patch :update, params: { id: mail, mail_set_id: mail_set, mail: attributes_for(:mail) }
        expect(assigns(:mail)).to eq mail
      end

      it 'assigns the mail set' do
        patch :update, params: { id: mail, mail_set_id: mail_set, mail: attributes_for(:mail) }
        expect(assigns(:mail_set)).to eq mail_set
      end

      it 'changes mail attributes' do
        patch :update, params: { id: mail, mail_set_id: mail_set, mail: { title: 'new title', body: 'new body'} }
        mail.reload
        expect(mail.title).to eq 'new title'
        expect(mail.body).to eq 'new body'
      end

      it 'redirect to updated mail' do
        patch :update, params: { id: mail, mail_set_id: mail_set, mail: { title: 'new title', body: 'new body'} }
        expect(response).to redirect_to mail_set_mail_path(assigns(:mail_set), assigns(:mail))
      end
    end

    context 'with invalid attributes' do
      it 'does not changes mail attributes with emptry title and body' do
        patch :update, params: { id: mail, mail_set_id: mail_set, mail: { title: nil, body: nil } }
        mail.reload
        expect(mail.title).not_to eq nil
        expect(mail.body).not_to eq nil
      end

      it 'does not changes mail attributes with too long title and body' do
        patch :update, params: { id: mail, mail_set_id: mail_set, mail: { title: "unfortunately, this title is too long for one mail", body: "Body is ok" } }
        mail.reload
        expect(mail.title).not_to eq "unfortunately, this title is too long for one mail"
        expect(mail.body).not_to eq "Body is ok"
      end

      it 'renders edit view' do
        patch :update, params: { id: mail, mail_set_id: mail_set, mail: { title: nil, body: nil } }
        expect(response).to render_template :edit
      end
    end
  end
end
