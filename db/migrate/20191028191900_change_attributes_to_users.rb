class ChangeAttributesToUsers < ActiveRecord::Migration[6.0]
  def change
    change_column :users, :attributes, :jsonb
  end
end
