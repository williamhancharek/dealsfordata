class AddApprovedColumnToBoxes < ActiveRecord::Migration[6.0]
  def change
    add_column :boxes, :approved, :boolean, default: FALSE
  end
end
