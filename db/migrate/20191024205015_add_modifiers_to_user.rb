class AddModifiersToUser < ActiveRecord::Migration[6.0]
  def change
    change_table :users do |t|
      t.string 'modifiers', array: true
    end
  add_index :users, :modifiers, using: 'gin'
  end
end
