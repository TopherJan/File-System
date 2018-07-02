class AddStatusAndDateModifiedToDocument < ActiveRecord::Migration[5.1]
  def change
    add_column :documents, :status, :text
	add_column :documents, :date_modified, :date
  end
end
