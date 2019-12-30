class AddRetailPriceandCurrentPriceToOffer < ActiveRecord::Migration[6.0]
  def change
    add_column :offers, :retail_price, :float
  end
end
