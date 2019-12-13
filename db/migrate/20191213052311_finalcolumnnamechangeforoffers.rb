class Finalcolumnnamechangeforoffers < ActiveRecord::Migration[6.0]
  def change
    rename_column :offers, :state, :status
  end
end
