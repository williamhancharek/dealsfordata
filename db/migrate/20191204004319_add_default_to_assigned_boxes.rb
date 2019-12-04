class AddDefaultToAssignedBoxes < ActiveRecord::Migration[6.0]
  def change
    change_column :users, :assigned_boxes, :integer, array: true, default: []
  end
end
