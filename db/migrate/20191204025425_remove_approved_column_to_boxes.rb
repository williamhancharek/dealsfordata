class RemoveApprovedColumnToBoxes < ActiveRecord::Migration[6.0]
  def change
    remove_column :boxes, :approved

  end
end
