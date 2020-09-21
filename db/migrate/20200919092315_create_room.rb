class CreateRoom < ActiveRecord::Migration[5.2]
  def change
    create_table :rooms do |t|
      t.integer :user_id, null: false
      t.integer :member_id, null: false
      t.text :uri_token, null: false
      t.integer :status, null: false, default: 0
    end
  end
end
