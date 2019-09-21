class AddUserRefToOffers < ActiveRecord::Migration[6.0]
  def change
    add_reference :offers, :user, foreign_key: true
  end
end
