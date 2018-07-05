class CreateJobtitles < ActiveRecord::Migration[5.1]
  def change
    create_table :jobtitles do |t|
	  t.text :name
      t.timestamps
    end
  end
end
