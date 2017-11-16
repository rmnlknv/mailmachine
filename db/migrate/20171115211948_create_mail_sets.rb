class CreateMailSets < ActiveRecord::Migration[5.1]
  def change
    create_table :mail_sets do |t|
      t.string :name
      t.text :addressee

      t.timestamps
    end
  end
end
