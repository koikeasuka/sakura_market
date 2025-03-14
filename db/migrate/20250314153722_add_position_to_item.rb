class AddPositionToItem < ActiveRecord::Migration[8.0]
  def change
    change_table :items, bulk: true do |t|
      t.integer :position, null: false, default: 1
    end
  end
end
