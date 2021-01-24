class ChangeAdminToAdmins< ActiveRecord::Migration[5.2]

  def change
  rename_table :admin, :admins
  end

end



