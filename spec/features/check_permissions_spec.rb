require 'rails_helper'

feature 'Not able to edit others emails', %q{
  In order to be able to edit only own emails
  As an authenticated User
  I don't want to have access to others emails
} do

  given(:user1) { create(:user) }
  given(:user2) { create(:user, email: 'test2@mail.com') }
  given!(:mail_set) { create(:mail_set, user_id: user2.id) }
  given!(:email) { create(:email, mail_set: mail_set, user_id: user2.id) }

  scenario 'Authenticated user edits others email' do
    sign_in user1
    visit edit_mail_set_email_path(mail_set, email)

    expect(page).to have_content 'You have no access.'
  end

  scenario 'Authenticated user edits others mail set' do
    sign_in user1
    visit edit_mail_set_path(mail_set)

    expect(page).to have_content 'You have no access.'
  end
end