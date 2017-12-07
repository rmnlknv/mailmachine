require 'rails_helper'

feature 'Add files to mail', %q{
  In order to send mails with attachments
  As an authenticated user
  I'd like to be able to attach files
} do

  given(:user) { create(:user) }
  given(:mail_set) { create(:mail_set, user_id: user.id) }

  background do
    sign_in user
    visit new_mail_set_mail_path(mail_set)
  end

  scenario 'User adds file when creates mail' do
    fill_in 'Mail title', with: 'My title'
    fill_in 'Mail body', with: 'My mail body'
    attach_file 'File', "#{Rails.root}/spec/spec_helper.rb" 
    click_on 'Create'

    expect(page).to have_content 'spec_helper.rb'
  end
end
