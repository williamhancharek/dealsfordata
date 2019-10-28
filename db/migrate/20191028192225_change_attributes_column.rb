class ChangeAttributesColumn < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :keywords
    remove_column :users, :tags
  end
end
