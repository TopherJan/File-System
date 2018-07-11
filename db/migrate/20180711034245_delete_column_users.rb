class DeleteColumnUsers < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :provider
	remove_column :users, :uid
	remove_column :users, :fullname
  end
end
