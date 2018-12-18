class CreateNotifications < ActiveRecord::Migration[5.1]
  def change
    create_table :notifications do |t|
      t.integer :user_id
	  t.text :message
      t.date :date
      t.timestamps
    end
  end
end
