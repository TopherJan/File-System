class CreateDoctypes < ActiveRecord::Migration[5.1]
  def change
    create_table :doctypes do |t|
      t.text :name
      t.timestamps
    end
  end
end
