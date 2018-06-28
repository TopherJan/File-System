class CreateDocuments < ActiveRecord::Migration[5.1]
  def change
    create_table :documents do |t|
      t.integer :doc_id
      t.string :name
      t.string :doc_type
      t.text :description
      t.string :location

      t.timestamps
    end
  end
end
