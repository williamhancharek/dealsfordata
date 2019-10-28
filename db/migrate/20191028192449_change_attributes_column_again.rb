class ChangeAttributesColumnAgain < ActiveRecord::Migration[6.0]
  def change
    rename_column :users, :attributes, :keywords
  end
end
