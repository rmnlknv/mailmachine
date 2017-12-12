class ChangeDefaultForSent < ActiveRecord::Migration[5.1]
  def change
  	change_column_default(:histories, :sent, false)
  end
end
