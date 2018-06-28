class ChangeTypeInDocument < ActiveRecord::Migration[5.1]
  def up
    remove_column :documents, :type
  end

  def down
    add_column :documents, :doc_type, :string
  end
end
