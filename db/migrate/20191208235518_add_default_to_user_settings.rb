class AddDefaultToUserSettings < ActiveRecord::Migration[6.0]
  def change
    change_column :users, :settings, :jsonb, default: {}
  end
end
