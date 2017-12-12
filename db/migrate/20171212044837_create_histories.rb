class CreateHistories < ActiveRecord::Migration[5.1]
  def change
    create_table :histories do |t|
      t.integer :email_id
      t.string :email_title
      t.datetime :queued
      t.integer :recipients_amount
      t.boolean :sent

      t.timestamps
    end
  end
end
