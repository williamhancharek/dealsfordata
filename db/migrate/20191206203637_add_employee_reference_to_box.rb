class AddEmployeeReferenceToBox < ActiveRecord::Migration[6.0]
  def change
    add_column :boxes, :employee_id, :bigint
  end
end
