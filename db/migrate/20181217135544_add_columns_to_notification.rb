class AddColumnsToNotification < ActiveRecord::Migration[5.1]
  def change
	add_column :notifications, :status, :boolean, :default => false
	add_column :notifications, :notif_type, :integer
	add_column :notifications, :doc_id, :integer
  end
end
