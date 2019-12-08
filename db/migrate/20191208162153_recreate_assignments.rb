class RecreateAssignments < ActiveRecord::Migration[6.0]
  def change
    create_table :assignments do |t|
      t.bigint :user_id, null: false
      t.bigint :box_id, null: false
      t.timestamps null: false
    end

    add_index :assignments, :user_id
    add_index :assignments, :box_id
    add_index :assignments, [:user_id, :box_id], unique: true
  end
end
