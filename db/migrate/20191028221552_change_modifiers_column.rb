class ChangeModifiersColumn < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :modifiers
  end
end
