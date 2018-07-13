class ChangeColumnForward < ActiveRecord::Migration[5.1]
  def change
	remove_column :forwards, :user_id
	remove_column :forwards, :doc_id
	
	add_column :forwards, :user_id, :integer
	add_column :forwards, :doc_id, :integer
  end
end
