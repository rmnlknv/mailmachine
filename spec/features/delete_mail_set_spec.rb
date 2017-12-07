require 'rails_helper'

feature 'Delete mail set', %q{
  In order to delete mail sets for mails
  As an authenticated user and mail set creator
  I want to be able to delete mail sets
} do

  given(:user) { create(:user) }
  given!(:mail_set) { create(:mail_set, user_id: user.id) }

  scenario 'Authenticated user deletes mail set' do
    sign_in user

    visit mail_sets_path
    click_on 'Delete'

    expect(page).to have_content 'Your mailset successfully deleted.'
  end

  scenario 'Non-authenticated user deletes mailset' do
    visit mail_sets_path

    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end
end
