class CreatePurchase < ActiveRecord::Migration[8.0]
  def change
    create_table :purchases do |t|
      t.bigint :user_id, null: false, index: true
      t.integer :shipping_fee, null: false, default: 0
      t.integer :cash_on_delivery_fee, null: false, default: 0
      t.integer :tax, null: false, default: 0

      t.timestamps
    end
  end
end
