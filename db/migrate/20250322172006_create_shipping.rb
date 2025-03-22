class CreateShipping < ActiveRecord::Migration[8.0]
  def change
    create_table :shippings do |t|
      t.bigint :purchase_id, null: false, index: true
      t.string :last_name, null: false, default: ''
      t.string :first_name, null: false, default: ''
      t.string :tel, null: false, default: ''
      t.string :post_code, null: false, default: ''
      t.bigint :prefecture_id, null: false
      t.string :city, null: false, default: ''
      t.string :other_address, null: false, default: ''
      t.date :delivery_date
      t.string :delivery_time_slot

      t.timestamps
    end
  end
end
