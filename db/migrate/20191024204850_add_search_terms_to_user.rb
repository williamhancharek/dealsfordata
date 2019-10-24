class AddSearchTermsToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :search_terms, :text
  end
end
