class AddKeywordsToUsers < ActiveRecord::Migration[6.0]
  def change
    change_table :users do |t|
      t.string :keywords, array: true
    end
  end
end
