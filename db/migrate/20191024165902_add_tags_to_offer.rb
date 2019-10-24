class AddTagsToOffer < ActiveRecord::Migration[6.0]
  def change
    change_table :offers do |t|
      t.string 'tags', array: true
    end
    
  add_index :offers, :tags, using: 'gin'
  end
end
