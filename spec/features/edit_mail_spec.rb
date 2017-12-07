require 'rails_helper'

feature 'Edit mail', %q{
  In order to edit mail
  As an authenticated user and mail creator
  I want to be able to edit mail
} do

  given(:user) { create(:user) }
  given(:mail_set) { create(:mail_set, user_id: user.id) }
  given(:mail) { create(:mail, mail_set_id: mail_set.id, user_id: user.id) }

  scenario 'Authenticated user edits mail' do
    sign_in user

    visit edit_mail_set_mail_path(mail_set, mail)
    fill_in 'Mail title', with: 'Updated title'
    fill_in 'Mail body', with: 'Updated body'
    click_on 'Update'

    expect(page).to have_content 'Your mail successfully updated.'
  end

  scenario 'Non-authenticated user edits mail' do
    visit edit_mail_set_mail_path(mail_set, mail)

    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end
end
