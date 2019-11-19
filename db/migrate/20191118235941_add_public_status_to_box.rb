class AddPublicStatusToBox < ActiveRecord::Migration[6.0]
  def change
    add_column :boxes, :public, :integer, default: 0
  end
end
