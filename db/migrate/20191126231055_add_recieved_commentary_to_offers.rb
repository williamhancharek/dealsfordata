class AddRecievedCommentaryToOffers < ActiveRecord::Migration[6.0]
  def change
    add_column :offers, :received_commentary, :string
  end
end
