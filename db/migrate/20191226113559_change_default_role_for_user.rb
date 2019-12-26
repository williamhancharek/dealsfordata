class ChangeDefaultRoleForUser < ActiveRecord::Migration[6.0]
  def change
    change_column_default(:users, :role, nil) 
  end
end
