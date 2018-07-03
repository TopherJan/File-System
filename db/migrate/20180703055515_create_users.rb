class CreateUsers < ActiveRecord::Migration[5.1]
  def change
  drop_table :users
  create_table :users do |t|
      t.string :provider
      t.string :uid
      t.string :name
      t.string :oauth_token
      t.string :id_token
      t.datetime :oauth_expires_at
      t.text :emailadd
      t.text :password
      t.text :first_name
      t.text :last_name
      t.text :job_title
      t.text :phone

      t.timestamps
    end
  end
end
