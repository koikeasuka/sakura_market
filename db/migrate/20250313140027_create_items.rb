class CreateItems < ActiveRecord::Migration[8.0]
  def change
    create_table :items do |t|
      t.string :name, null: false, default: ''
      t.text :description, null: false
      t.integer :price, null: false, default: 0

      t.timestamps
    end
  end
end
