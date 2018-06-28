class ChangeTypeInEvent < ActiveRecord::Migration[5.1]
  def up
    remove_column :events, :type
  end

  def down
    add_column :events, :event_type, :string
  end
end
