class CreateAttachments < ActiveRecord::Migration[5.1]
  def change
    create_table :attachments do |t|
      t.string :name
      t.string :attachment
      t.integer :doc_id

      t.timestamps
    end
  end
end
