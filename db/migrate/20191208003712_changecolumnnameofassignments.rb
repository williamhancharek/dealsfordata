class Changecolumnnameofassignments < ActiveRecord::Migration[6.0]
  def change
    rename_column :assignments, :employee_id, :user_id
    rename_column :assignments, :assigned_box_id, :box_id
  end
end
