class AddAuthorToDocument < ActiveRecord::Migration[5.1]
  def change
    add_column :documents, :author_name, :text
  end
end
