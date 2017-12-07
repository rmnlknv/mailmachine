require 'rails_helper'

feature 'New mail', %q{
  In order to send mail to addressee
  As an authenticated User
  I want to be able to create mails
} do

  given(:user) { create(:user) }
  given!(:mail_set) { create(:mail_set, user_id: user.id ) }

  scenario 'Authenticated user create mail' do
    sign_in user
    visit new_mail_set_mail_path(mail_set)

    fill_in 'Mail title', with: 'My title'
    fill_in 'Mail body', with: 'My mail body'
    click_on 'Create'
    end
end