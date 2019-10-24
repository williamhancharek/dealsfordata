class AddOptionsArrayToOffer < ActiveRecord::Migration[6.0]
  def change
    change_table :offers do |t|
      t.string 'options', array: true
    end

  add_index :offers, :options, using: 'gin'
  end
end
