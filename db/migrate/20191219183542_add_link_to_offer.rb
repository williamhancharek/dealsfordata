class AddLinkToOffer < ActiveRecord::Migration[6.0]
  def change
    add_column :offers, :link, :text
  end
end
