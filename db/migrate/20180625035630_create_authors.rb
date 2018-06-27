class CreateAuthors < ActiveRecord::Migration[5.1]
  def change
	
    create_table :authors do |t|
      t.integer :author_id
      t.string :name
      t.string :contact
      t.string :department
      t.string :agency
      t.string :address
      t.integer :doc_id

      t.timestamps
    end
  end
end
