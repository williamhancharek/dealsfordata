class AddMaxPriceMinPricetoBox < ActiveRecord::Migration[6.0]
  def change
    add_column :boxes, :min_price, :int
    add_column :boxes, :max_price, :int
  end
end
