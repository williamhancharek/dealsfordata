class AddItemRefToAccounts < ActiveRecord::Migration[6.0]
  def change
    add_reference :accounts, :item, foreign_key: true
  end
end
