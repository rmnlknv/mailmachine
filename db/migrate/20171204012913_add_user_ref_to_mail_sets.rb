class AddUserRefToMailSets < ActiveRecord::Migration[5.1]
  def change
    add_reference :mail_sets, :user, foreign_key: true
  end
end
