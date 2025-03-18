class CreateShippingAddresses < ActiveRecord::Migration[8.0]
  def change
    create_table :shipping_addresses do |t|
      t.string :last_name, null: false, default: ''
      t.string :first_name, null: false, default: ''
      t.integer :tel, null: false, default: 0
      t.string :post_code, null: false, default: ''
      t.bigint :prefecture_id, null: false
      t.string :city, null: false, default: ''
      t.string :other_address, null: false, default: ''

      t.timestamps
    end
  end
end
