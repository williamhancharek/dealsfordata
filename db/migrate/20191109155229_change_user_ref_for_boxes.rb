class ChangeUserRefForBoxes < ActiveRecord::Migration[6.0]
  def change
    remove_reference :boxes, :user
  end
end
