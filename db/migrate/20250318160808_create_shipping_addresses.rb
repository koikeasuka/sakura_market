class CreateShippingAddresses < ActiveRecord::Migration[8.0]
  def change
    create_table :shipping_addresses do |t|
      t.bigint :user_id, null: false, index: true
      t.string :last_name, null: false, default: ''
      t.string :first_name, null: false, default: ''
      t.string :tel, null: false, default: ''
      t.string :post_code, null: false, default: ''
      t.bigint :prefecture_id, null: false
      t.string :city, null: false, default: ''
      t.string :other_address, null: false, default: ''

      t.timestamps
    end
  end
end
