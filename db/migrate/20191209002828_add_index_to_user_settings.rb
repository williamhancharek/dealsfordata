class AddIndexToUserSettings < ActiveRecord::Migration[6.0]
  def change
    add_index  :users, :settings, using: :gin
  end
end
