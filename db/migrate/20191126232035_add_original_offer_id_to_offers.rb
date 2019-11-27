class AddOriginalOfferIdToOffers < ActiveRecord::Migration[6.0]
  def change
    add_column :offers, :original_offer_id, :bigint
  end
end
