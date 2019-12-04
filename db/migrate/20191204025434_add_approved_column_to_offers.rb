class AddApprovedColumnToOffers < ActiveRecord::Migration[6.0]
  def change
    add_column :offers, :approved, :boolean, default: FALSE
  end
end
