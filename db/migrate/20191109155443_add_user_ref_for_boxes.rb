class AddUserRefForBoxes < ActiveRecord::Migration[6.0]
  def change
    add_reference :boxes, :user, null: false, foreign_key: true
  end
end
