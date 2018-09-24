class ChangeRequestPasswordField < ActiveRecord::Migration[5.1]
  def change
    rename_column :requests, :password, :password_digest
  end
end
