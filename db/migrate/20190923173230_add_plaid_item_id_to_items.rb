class AddPlaidItemIdToItems < ActiveRecord::Migration[6.0]
  def change
    add_column :items, :plaid_item_id, :string
  end
end
