class CreateJoinTableUsersBoxes < ActiveRecord::Migration[6.0]
  def change
    create_join_table :users, :boxes do |t|
      # t.index [:user_id, :box_id]
      # t.index [:box_id, :user_id]
    end
  end
end
