class CreateJsonbModifiersColumn < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :modifiers, :jsonb
  end
end
