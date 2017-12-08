class RenameMailIdToEmailId < ActiveRecord::Migration[5.1]
  def change
  	remove_index :attachments, :mail_id
  	rename_column :attachments, :mail_id, :email_id
  	add_index :attachments, :email_id
  end
end
