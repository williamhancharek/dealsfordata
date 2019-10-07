class AddDefaultEmptyArrayToUsers < ActiveRecord::Migration[6.0]
  def change
    change_column :users, :keywords, :string, array: true, default: []
  end
end
