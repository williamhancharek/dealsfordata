class AddEmployeeIndexToBox < ActiveRecord::Migration[6.0]
  def change
    add_index :boxes, :employee_id
  end
end
