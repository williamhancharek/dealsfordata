class AddStatusToOffers < ActiveRecord::Migration[6.0]
  def change
    add_column :offers, :status, :boolean, default: TRUE
  end
end
