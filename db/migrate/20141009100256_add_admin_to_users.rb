class AddAdminToUsers < ActiveRecord::Migration
  def change
    # Because we won’t want most users to be given admin permissions, we’ll add a , default: false'.
    add_column :users, :admin, :boolean, default: false
  end
end
