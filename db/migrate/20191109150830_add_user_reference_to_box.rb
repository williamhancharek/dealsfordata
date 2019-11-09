class AddUserReferenceToBox < ActiveRecord::Migration[6.0]
  def change
    add_reference :boxes, :user, index: true
  end
end
