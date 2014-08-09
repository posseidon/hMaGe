class AddDefaultValueOnRoleToUsers < ActiveRecord::Migration
  def change
    change_column :users, :role, :string, :default => 'viewer'
  end
end
