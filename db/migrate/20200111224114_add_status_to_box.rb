class AddStatusToBox < ActiveRecord::Migration[6.0]
  def change
    add_column :boxes, :status, :string
  end
end
