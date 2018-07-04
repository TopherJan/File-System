class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :provider
      t.string :uid
      t.string :fullname
      t.string :emailadd
      t.string :first_name
      t.string :last_name
      t.string :password
      t.string :job_title
      t.string :phone

      t.timestamps
    end
  end
end
