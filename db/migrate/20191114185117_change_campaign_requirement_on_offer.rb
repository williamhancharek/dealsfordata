class ChangeCampaignRequirementOnOffer < ActiveRecord::Migration[6.0]
  def change
    change_column :offers, :campaign_id, :int, null: true
  end
end
