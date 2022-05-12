class RenameNameColumnOfUsers < ActiveRecord::Migration[7.0]
  def change
    rename_column :users, :name, :username
    add_column :users, :token, :string
  end
end
