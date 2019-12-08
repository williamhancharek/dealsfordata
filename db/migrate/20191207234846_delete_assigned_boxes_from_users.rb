class DeleteAssignedBoxesFromUsers < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :assigned_boxes
  end
end
