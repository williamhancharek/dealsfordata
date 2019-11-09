class CreateBoxes < ActiveRecord::Migration[6.0]
  def change
    change_table :boxes do |t|

      t.timestamps
    end
  end
end
