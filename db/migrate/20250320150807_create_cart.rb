class CreateCart < ActiveRecord::Migration[8.0]
  def change
    create_table :carts do |t|
      t.bigint :user_id, null: false, index: true

      t.timestamps
    end
  end
end
