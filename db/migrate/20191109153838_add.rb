class Add < ActiveRecord::Migration[6.0]
  def change
    add_reference :offers, :user, null: false, foreign_key: true
  end
end
