class AddAttributesToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :attributes, :json
  end
end
