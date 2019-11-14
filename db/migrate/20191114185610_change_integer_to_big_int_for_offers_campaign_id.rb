class ChangeIntegerToBigIntForOffersCampaignId < ActiveRecord::Migration[6.0]
  def change
    change_column :offers, :campaign_id, :Bigint, null: true
  end
end
