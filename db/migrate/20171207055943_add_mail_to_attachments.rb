class AddMailToAttachments < ActiveRecord::Migration[5.1]
  def change
  	add_column :attachments, :mail_id, :integer
  	add_index :attachments, :mail_id
  end
end
