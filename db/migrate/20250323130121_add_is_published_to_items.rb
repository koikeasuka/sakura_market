class AddIsPublishedToItems < ActiveRecord::Migration[8.0]
  def change
    add_column :items, :is_published, :boolean, null: false, default: true
  end
end
