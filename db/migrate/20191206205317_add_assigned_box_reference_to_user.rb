class AddAssignedBoxReferenceToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :assigned_box_id, :bigint
    add_index :users, :assigned_box_id
  end
end
