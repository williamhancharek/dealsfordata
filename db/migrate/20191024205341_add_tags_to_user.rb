class AddTagsToUser < ActiveRecord::Migration[6.0]
  def change
    change_table :users do |t|
      t.string 'tags', array: true
    end
  add_index :users, :tags, using: 'gin'
  end
end
