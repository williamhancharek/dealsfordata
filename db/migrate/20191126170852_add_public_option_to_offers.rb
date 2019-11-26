class AddPublicOptionToOffers < ActiveRecord::Migration[6.0]
  def change
    add_column :offers, :public_selected_option, :string
    add_column :offers, :public_options, :string, array: true
    add_column :offers, :commentary, :string
    add_column :offers, :referrer, :bigint, array: true
  end
end
