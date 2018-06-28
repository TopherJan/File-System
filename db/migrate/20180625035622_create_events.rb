class CreateEvents < ActiveRecord::Migration[5.1]
  def change
	
    create_table :events do |t|
      t.integer :event_id
      t.date :date
      t.string :event_type
      t.text :remarks
      t.integer :doc_id

      t.timestamps
    end
  end
end
