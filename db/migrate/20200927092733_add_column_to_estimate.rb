class AddColumnToEstimate < ActiveRecord::Migration[5.2]
  def change
    add_column :estimates, :send_mail_flag, :boolean, default: false
  end
end
