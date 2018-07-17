class AddUserIDtoDocument < ActiveRecord::Migration[5.1]
  def change
	add_column :documents, :user_id, :integer
  end
end
