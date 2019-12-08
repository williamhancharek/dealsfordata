class Changeemployeesboxestable < ActiveRecord::Migration[6.0]
  def change
    drop_table :employees_boxes

    create_table :employees_boxes, id: false do |t|
      t.bigint :employee_id, null: false
      t.bigint :assigned_box_id, null: false
      t.timestamps null: false

    end
    add_index :employees_boxes, :employee_id
    add_index :employees_boxes, :assigned_box_id
    add_index :employees_boxes, [:employee_id, :assigned_box_id], unique: true
  end
end
