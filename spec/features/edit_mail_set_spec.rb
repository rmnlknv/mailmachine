require 'rails_helper'

feature 'Edit mail set', %q{
  In order to edit mail sets for mails
  As an authenticated user and mail set creator
  I want to be able to edit mail sets
} do

  given(:user) { create(:user) }
  given(:mail_set) { create(:mail_set, user_id: user.id) }

  scenario 'Authenticated user edits mail set' do
    sign_in user

    visit edit_mail_set_path(mail_set)
    fill_in 'Name', with: 'Updated mail set'
    fill_in 'Addressee', with: 'updated@user.com'
    click_on 'Update'

    expect(page).to have_content 'Your mailset successfully updated.'
  end

  scenario 'Non-authenticated user edits mailset' do
    visit edit_mail_set_path(mail_set)

    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end
end
