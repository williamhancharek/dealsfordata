class RemoveUserRefFromTransactions < ActiveRecord::Migration[6.0]
  def change
    remove_reference :transactions, :user, foreign_key: true
  end
end
