class CreateJoinTableForEmployeesAndBoxes < ActiveRecord::Migration[6.0]
  def change
    create_table :employees_boxes do |t|
      t.bigint :employee_id, null: false
      t.bigint :assigned_box_id, null: false
      t.timestamps null: false

    end
    add_index :employees_boxes, :employee_id
    add_index :employees_boxes, :assigned_box_id
    add_index :employees_boxes, [:employee_id, :assigned_box_id], unique: true
      # t.index [:box_id, :user_id]
  end
end
