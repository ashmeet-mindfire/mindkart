class RenameAdminToIsAdminInUsers < ActiveRecord::Migration[7.2]
  def change
    rename_column :users, :admin, :is_admin
  end
end
