require 'rails_helper'

feature 'Delete mail', %q{
  In order to delete mail
  As an authenticated user and mail creator
  I want to be able to delete mail
} do

  given(:user) { create(:user) }
  given!(:mail_set) { create(:mail_set, user_id: user.id) }
  given!(:email) { create(:email, mail_set_id: mail_set.id, user_id: user.id) }

  scenario 'Authenticated user deletes mail set' do
    sign_in user

    visit mail_set_path(mail_set)
    click_on 'Delete'

    expect(page).to have_content 'Your mail successfully deleted.'
  end

  scenario 'Non-authenticated user deletes mailset' do
    visit mail_set_path(mail_set)

    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end
end
