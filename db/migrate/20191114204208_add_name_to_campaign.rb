class AddNameToCampaign < ActiveRecord::Migration[6.0]
  def change
    add_column :campaigns, :name, :string
  end
end
