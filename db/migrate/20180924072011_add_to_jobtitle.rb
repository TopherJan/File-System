class AddToJobtitle < ActiveRecord::Migration[5.1]
  def change
	add_column :jobtitles, :viewDocument, :boolean, :default => false
	add_column :jobtitles, :addDocument, :boolean, :default => false
	add_column :jobtitles, :editDocument, :boolean, :default => false
	add_column :jobtitles, :deleteDocument, :boolean, :default => false
	add_column :jobtitles, :forwardDocument, :boolean, :default => false
	add_column :jobtitles, :addEvent, :boolean, :default => false
	add_column :jobtitles, :uploadFile, :boolean, :default => false
	add_column :jobtitles, :deleteFile, :boolean, :default => false
	add_column :jobtitles, :userRequest, :boolean, :default => false
	add_column :jobtitles, :jobtitleSettings, :boolean, :default => false
	add_column :jobtitles, :doctypeSettings, :boolean, :default => false
	add_column :jobtitles, :userSettings, :boolean, :default => false
  end
end
