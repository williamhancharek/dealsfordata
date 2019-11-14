class AddCampaignReferenceToOffers < ActiveRecord::Migration[6.0]
  def change
    add_reference :offers, :campaign, null: false, foreign_key: true
  end
end
