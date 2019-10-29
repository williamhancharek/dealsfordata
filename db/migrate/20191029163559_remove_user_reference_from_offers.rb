class RemoveUserReferenceFromOffers < ActiveRecord::Migration[6.0]
  def change
    remove_reference :offers, :user, index: true
  end
end
