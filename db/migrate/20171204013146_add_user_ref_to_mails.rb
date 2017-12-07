class AddUserRefToMails < ActiveRecord::Migration[5.1]
  def change
    add_reference :mails, :user, foreign_key: true
  end
end
