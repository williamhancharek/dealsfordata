class AddAssignedBoxesToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :assigned_boxes, :integer, array: true
  end
end
