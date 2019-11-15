class RemoveSearchTermsKeywordsModifiersFromUsers < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :keywords
    remove_column :users, :modifiers
    remove_column :users, :search_terms
  end
end
