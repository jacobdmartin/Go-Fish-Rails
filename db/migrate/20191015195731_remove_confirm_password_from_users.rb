class RemoveConfirmPasswordFromUsers < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :confirm_password, :string
    remove_column :users, :password, :string
  end
end
