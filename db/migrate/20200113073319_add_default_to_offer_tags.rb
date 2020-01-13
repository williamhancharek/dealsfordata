class AddDefaultToOfferTags < ActiveRecord::Migration[6.0]
  def change
    change_column :offers, :tags, :string, array: true, default: []
  end
end
