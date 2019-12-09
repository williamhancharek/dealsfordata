class AddNullFalsetoUserSettings < ActiveRecord::Migration[6.0]
  def change
    change_column :users, :settings, :jsonb, null: false, default: {}
  end
end
