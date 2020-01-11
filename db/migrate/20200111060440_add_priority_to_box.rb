class AddPriorityToBox < ActiveRecord::Migration[6.0]
  def change
    add_column :boxes, :priority, :string
  end
end
