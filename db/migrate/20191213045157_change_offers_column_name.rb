class ChangeOffersColumnName < ActiveRecord::Migration[6.0]
  def change
    remove_column :offers, :status
  end
end
