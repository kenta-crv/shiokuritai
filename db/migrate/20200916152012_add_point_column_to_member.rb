class AddPointColumnToMember < ActiveRecord::Migration[5.2]
  def change
    add_column :members, :point, :integer, default: 0, after: :email
  end
end
