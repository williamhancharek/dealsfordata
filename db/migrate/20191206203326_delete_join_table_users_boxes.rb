class DeleteJoinTableUsersBoxes < ActiveRecord::Migration[6.0]
  def change
    drop_table :boxes_users
      # t.index [:user_id, :box_id]
      # t.index [:box_id, :user_id]
  end
end
