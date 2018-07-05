class CreateRequests < ActiveRecord::Migration[5.1]
  def change
    create_table :requests do |t|
	  t.text :emailadd
      t.text :first_name
      t.text :last_name
      t.text :password
      t.text :job_title
      t.text :phone
	  
      t.timestamps
    end
  end
end
