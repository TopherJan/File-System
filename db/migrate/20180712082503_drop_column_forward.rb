class DropColumnForward < ActiveRecord::Migration[5.1]
  def change
	remove_column :forwards, :received
	add_column :forwards, :status, :text
  end
end
