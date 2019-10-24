class AddSelectedOptionToOffers < ActiveRecord::Migration[6.0]
  def change
    change_table :offers do |t|
      t.string 'selected_option'
    end
  end
end
