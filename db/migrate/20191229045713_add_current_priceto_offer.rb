class AddCurrentPricetoOffer < ActiveRecord::Migration[6.0]
  def change
    add_column :offers, :current_price, :float
  end
end
