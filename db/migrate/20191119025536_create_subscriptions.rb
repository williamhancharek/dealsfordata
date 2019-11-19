class CreateSubscriptions < ActiveRecord::Migration[6.0]
  def change
    create_table :subscriptions do |t|
      t.integer 'subscriber_id', :null => false
      t.integer 'subscribing_id', :null => false

      t.timestamps null: false
    end
    add_index :subscriptions, :subscribing_id
    add_index :subscriptions, :subscriber_id
    add_index :subscriptions, [:subscribing_id, :subscriber_id], unique: true
  end
end
