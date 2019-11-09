class AddBoxReferenceToOffers < ActiveRecord::Migration[6.0]
  def change
    add_reference :offers, :box, null: false, foreign_key: true
  end
end
