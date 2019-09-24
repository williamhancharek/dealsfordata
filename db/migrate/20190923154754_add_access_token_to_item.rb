class AddAccessTokenToItem < ActiveRecord::Migration[6.0]
  def change
    add_column :items, :access_token, :string
  end
end
