class CreateCartItems < ActiveRecord::Migration[8.0]
  def change
    create_table :cart_items do |t|
      t.bigint :cart_id, null: false, index: true
      t.bigint :item_id, null: false, index: true

      t.timestamps
    end
  end
end
