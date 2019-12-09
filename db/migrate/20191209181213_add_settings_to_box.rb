class AddSettingsToBox < ActiveRecord::Migration[6.0]
  def change
    add_column :boxes, :settings, :jsonb, null: false, default: {}
    add_index  :boxes, :settings, using: :gin
  end
end
