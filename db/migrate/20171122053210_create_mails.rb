class CreateMails < ActiveRecord::Migration[5.1]
  def change
    create_table :mails do |t|
      t.string :title
      t.text :body

      t.references :mail_set, index: true
      t.timestamps
    end
  end
end
