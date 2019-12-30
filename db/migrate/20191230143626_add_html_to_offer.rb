class AddHtmlToOffer < ActiveRecord::Migration[6.0]
  def change
    add_column :offers, :html, :text
  end
end
