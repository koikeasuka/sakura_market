class CreatePurchaseItems < ActiveRecord::Migration[8.0]
  def change
    create_table :purchase_items do |t|
      t.bigint :purchase_id, null: false, index: true
      t.bigint :item_id, null: false, index: true
      t.integer :price, null: false, default: 0

      t.timestamps
    end
  end
end
