class CreateAssignments < ActiveRecord::Migration[6.0]
  def change
    rename_table :employees_boxes, :assignments
  end
end
