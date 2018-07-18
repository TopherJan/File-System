class CreateLogs < ActiveRecord::Migration[5.1]
  def change
    create_table :logs do |t|
	  t.integer :doc_id
	  t.text :action
	  
      t.timestamps
    end
  end
end
