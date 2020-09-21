class ReferUserToEstimate < ActiveRecord::Migration[5.2]
  def change
    add_column :estimates, :user_id, :integer, after: :remarks
  end
end
