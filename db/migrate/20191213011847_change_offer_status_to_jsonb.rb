class ChangeOfferStatusToJsonb < ActiveRecord::Migration[6.0]
  def change
    add_column :offers, :state, :jsonb, null: false, default: {}
    add_index :offers, :state, using: :gin
  end
end
