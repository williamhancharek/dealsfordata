class RemoveJoinsFromEmployeesAndBoxes < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :assigned_box_id
    remove_column :boxes, :employee_id
  end
end
