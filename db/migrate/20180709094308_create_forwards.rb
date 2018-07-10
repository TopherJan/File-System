class CreateForwards < ActiveRecord::Migration[5.1]
  def change
    create_table :forwards do |t|
      t.text :user_id
      t.text :doc_id
      t.timestamps
    end
  end
end
