class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.text :emailadd
      t.text :password
      t.text :first_name
      t.text :last_name
      t.text :job_title
      t.text :phone
	  t.timestamps null: false
    end
  end
end
