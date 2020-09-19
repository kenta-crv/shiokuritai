class AddColumnToMessage < ActiveRecord::Migration[5.2]
  def change
    add_column :messages, :room_id, :integer
    add_column :messages, :estimate_id, :integer
    add_column :messages, :content, :text
    add_column :messages, :is_user, :boolean
    add_column :messages, :is_read, :boolean, default: false
  end
end
