class RemoveUserRefFromOffers < ActiveRecord::Migration[6.0]
  def change
    remove_foreign_key :offers, :users
  end
end
