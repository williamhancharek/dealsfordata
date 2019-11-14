class ReAddForeignKeyCampaignFromOffer < ActiveRecord::Migration[6.0]
  def change
    add_reference :offers, :campaign, null: true, foreign_key: true
  end
end
