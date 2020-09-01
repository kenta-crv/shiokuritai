class AddColumnToList < ActiveRecord::Migration[5.2]
  def change
    add_reference :lists, :worker, foreign_key: true
  end
end
