class AddAttributesToBox < ActiveRecord::Migration[6.0]
  def change
    change_table :boxes do |t|
      t.string "gender"
      t.float "latitude"
      t.float "longitude"
      t.string "street"
      t.string "city"
      t.string "state"
      t.string "country"
      t.text "search_terms"
      t.string "name"
      t.jsonb "keywords", null: false, default: '{}'
      t.jsonb "modifiers", null: false, default: '{}'
    end
  end
end
